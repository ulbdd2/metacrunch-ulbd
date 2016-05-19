# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "metacrunch/ubpb/version"

Gem::Specification.new do |spec|
  spec.name          = "metacrunch-ulbd"
  spec.version       = Metacrunch::UBPB::VERSION
  spec.authors       = ["René Sprotte", "Michael Sievers"]
  spec.email         = "r.sprotte@ub.uni-paderborn.de"
  spec.summary       = %q{metacrunch extensions for internal use at University Library Paderborn}
  spec.homepage      = "http://github.com/ulbdd2/metacrunch-ulbd"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "metacrunch-mab2", "~> 1.2"
  spec.add_dependency "isbn",            "~> 2.0.11"
  spec.add_dependency "nokogiri",        "~> 1.6"
end
