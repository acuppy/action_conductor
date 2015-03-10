# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'conductor/version'

Gem::Specification.new do |spec|
  spec.name          = "conductor-rails"
  spec.version       = Conductor::VERSION
  spec.authors       = ["Adam Cuppy"]
  spec.email         = ["adam@codingzeal.com"]
  spec.summary       = %q{DRY-up Rails controllers by leveraging interchangeable conductors to export data}
  spec.homepage      = "https://github.com/acuppy/conductor-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rails', '~> 4.0', '>= 4.0.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'
end
