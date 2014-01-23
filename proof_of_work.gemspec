Gem::Specification.new do |s|
  s.name              = "proof_of_work"
  s.version           = "0.1"
  s.summary           = "Hashcash algorithm"
  s.description       = "Hashcash version 1 algorithm generator and checker"
  s.authors           = ["elcuervo"]
  s.licenses          = ["MIT", "HUGWARE"]
  s.email             = ["yo@brunoaguirre.com"]
  s.homepage          = "http://github.com/elcuervo/proof_of_work"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files test`.split("\n")

  s.add_development_dependency("minitest",        "~> 5.2.2")
  s.add_development_dependency("minitest-given",  "~> 3.5.0")
end
