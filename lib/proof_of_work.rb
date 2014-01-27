require "openssl"

class ProofOfWork
  VERSION = 1

  class << self
    def generate(identifier, options = {})
      options[:now]           ||= Time.now
      options[:bits]          ||= 20
      options[:extension]     ||= ""
      options[:salt_chars]    ||= 8
      options[:stamp_seconds] ||= false

      timestamp = if !!options[:stamp_seconds]
                    options[:now].strftime("%y%m%d%H%M%S")
                  else
                    options[:now].strftime("%y%m%d")
                  end

      challenge = "%s:" * 6 % [
        VERSION,
        options[:bits],
        timestamp,
        identifier,
        options[:extension],
        salt(options[:salt_chars])
      ]

      challenge + hashcash(challenge, options[:bits])
    end

    def valid?(stamp, options = {})
      _, bits_claim, date, identifier, extension, rand, counter = stamp.split(":")

      return false if options[:identifier] && options[:identifier] != identifier
      return false if options[:bits] && options[:bits].to_i > bits_claim.to_i

      if options[:expiration_date]
        return false if date < options[:expiration_date].strftime("%y%m%d%H%M%S")
      end

      hex_digits = (bits_claim.to_i/4.0).floor.to_i

      sha1 = OpenSSL::Digest::SHA1.new
      sha1 << stamp

      is_valid = sha1.hexdigest.start_with?("0" * hex_digits)
      yield(extension) if block_given?

      is_valid
    end

    private

    def salt(length)
      letters = [*("a".."z"), *("A".."Z"), "+", "/", "="]
      length.times.map{ letters.sample }.join
    end

    def hashcash(challenge, bits)
      hex_digits = (bits/4.0).ceil
      zeros = "0" * hex_digits
      counter = 0

      loop do
        sha1 = OpenSSL::Digest::SHA1.new
        sha1 << challenge
        sha1 << counter.to_s(16)

        digest = sha1.hexdigest
        section = digest[0...hex_digits]

        return counter.to_s(16) if section == zeros

        counter += 1
      end
    end
  end
end
