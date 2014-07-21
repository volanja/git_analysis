# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_analysis/version'

Gem::Specification.new do |spec|
  spec.name          = "git_analysis"
  spec.version       = GitAnalysis::VERSION
  spec.authors       = ["volanja"]
  spec.email         = ["wandervogel.erde@gmail.com"]
  spec.summary       = %q{Analysis data by git log}
  spec.description   = %q{Analysis data by git log}
  spec.homepage      = "https://github.com/volanja"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.6' ,'>= 1.6.2'
  spec.add_development_dependency 'rake', '~> 10.3', '>= 10.3.2'
  spec.add_development_dependency 'thor', '~> 0.19', '>= 0.19.1'
  spec.add_development_dependency 'ruport', '~> 1.6', '>= 1.6.3'
  spec.add_development_dependency 'rugged', '~> 0.21', '>= 0.21.0'
  spec.add_development_dependency 'oj', '~> 2.9', '>= 2.9.9'

  spec.add_runtime_dependency 'thor', '~> 0.19', '>= 0.19.1'
  spec.add_runtime_dependency 'ruport', '~> 1.6', '>= 1.6.3'
  spec.add_runtime_dependency 'rugged', '~> 0.21', '>= 0.21.0'
  spec.add_runtime_dependency 'oj', '~> 2.9', '>= 2.9.9'
end
