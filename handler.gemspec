# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'handler/version'

Gem::Specification.new do |spec|
  spec.name          = "handler"
  spec.version       = Handler::VERSION
  spec.authors       = ["Adam Cuppy"]
  spec.email         = ["adam@codingzeal.com"]
  spec.summary       = %q{DRY-up Rails Controller by leveraging Handlers}
  spec.homepage      = "https://github.com/acuppy/handler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0.0"
  spec.add_development_dependency "rails", "~> 4.1.0"
  spec.add_development_dependency "guard", "~> 2.10.0"
  spec.add_development_dependency "guard-rspec", "~> 4.3.1"
  spec.add_development_dependency "pry-debugger"
end
