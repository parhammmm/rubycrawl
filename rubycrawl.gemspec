# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubycrawl/version'

Gem::Specification.new do |spec|
	spec.name          = "rubycrawl"
	spec.version       = Rubycrawl::VERSION
	spec.authors       = ["Parham Saidi"]
	spec.email         = ["parham@parha.me"]
	spec.description   = "A simple crawler written for learning basics of ruby." 
	spec.summary       = "Should not be used for anything other than play" 
	spec.homepage      = "http://parha.me"
	spec.license       = "MIT"

	spec.files         = `git ls-files`.split($/)
	spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]

	spec.add_dependency "bloom-filter"
	spec.add_dependency "rest-client" 
	spec.add_dependency "nokogiri"
	spec.add_development_dependency "bundler", "~> 1.3"
	spec.add_development_dependency "rake"
end
