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
end
