# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autotask_api/version'

Gem::Specification.new do |spec|
  spec.name          = "autotask_api"
  spec.version       = AutotaskAPI::VERSION
  spec.authors       = ["Patrick Lenz"]
  spec.email         = ["plenz@topmedia.de"]
  spec.description   = %q{A wrapper for the Autotask API}
  spec.summary       = %q{A wrapper for the Autotask API}
  spec.homepage      = "http://github.com/scoop/autotask_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "activesupport", "~> 3.2.0"
  spec.add_dependency "savon", '~> 2.0'
end
