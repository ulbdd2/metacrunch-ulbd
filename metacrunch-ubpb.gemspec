require File.expand_path("../lib/metacrunch/ubpb/version", __FILE__)

Gem::Specification.new do |s|
  s.authors       = ["René Sprotte", "Michael Sievers"]
  s.email         = "r.sprotte@ub.uni-paderborn.de"
  s.summary       = %q{metacrunch extensions for internal use at University Library Paderborn}
  s.description   = s.summary
  s.homepage      = "http://github.com/ubpb/metacrunch-ubpb"
  s.licenses      = ["MIT"]

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.name          = "metacrunch-ubpb"
  s.require_paths = ["lib"]
  s.version       = Metacrunch::UBPB::VERSION

  s.required_ruby_version = ">= 2.2.0"

  s.add_dependency "metacrunch",               "~> 2.1"
  s.add_dependency "metacrunch-elasticsearch", "~> 1.0"
  s.add_dependency "metacrunch-mab2",          "~> 1.0"
end
