# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "metacrunch/ubpb/version"

Gem::Specification.new do |spec|
  spec.name          = "metacrunch-ubpb"
  spec.version       = Metacrunch::UBPB::VERSION
  spec.authors       = ["René Sprotte", "Michael Sievers"]
  spec.summary       = %q{metacrunch extensions for internal use at University Library Paderborn}
  spec.homepage      = "http://github.com/ubpb/metacrunch-ubpb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "metacrunch",      "~> 3.0.0.dev"
  spec.add_dependency "metacrunch-mab2", "~> 1.2"
  spec.add_dependency "isbn",            "~> 2.0.11"
  spec.add_dependency "nokogiri",        "~> 1.6"
end
