$: << "lib"

require "minitest"
require "minitest/given"
require "minitest/autorun"
require "proof_of_work"

describe ProofOfWork do
  context "The generated hash is valid?" do
    When(:hashcash) { ProofOfWork.generate("test") }
    Then { ProofOfWork.valid?(hashcash) == true }
  end

  context "Accessing extension" do
    Given(:hashcash) do
      ProofOfWork.generate("unique_user_id",
        extension: "Hello_this_is_dog", # Something you want to add to the hashcash
        salt_chars: 1
      )
    end

    When(:extension) do
      extension = nil
      ProofOfWork.valid?(hashcash) { |ext| extension = ext }
      extension
    end

    Then { extension == "Hello_this_is_dog" }

  end

  context "Show optional usage" do
    When(:hashcash) do
      ProofOfWork.generate("unique_user_id",
        now: Time.now + 3600 * 10, # Change curernt time to perfonm the validation
        bits: 2,
        extension: "Im_a_unique_thing_you_can_add",
        salt_chars: 1,
        stamp_seconds: true
      )
    end

    Then do
      ProofOfWork.valid?(hashcash,
        identifier: "unique_user_id", # Checks for the unique id
        bits: 2, # Checks if it has the correct amount of bits
        expiration_date: Time.now - 3600 # Allow only hashes that have not expired
      )
    end
  end
end
