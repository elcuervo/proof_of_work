$: << "lib"

require "minitest"
require "minitest/given"
require "minitest/autorun"
require "proof_of_work"

describe ProofOfWork do
  context "the lenght of the hash" do
    When(:hash) { ProofOfWork.generate("test") }
    Then { ProofOfWork.valid?(hash) == true }
  end
end
