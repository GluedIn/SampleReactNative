# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods_clean.rb'

Gem::Specification.new do |spec|
  spec.name          = "cocoapods-clean"
  spec.version       = CocoapodsClean::VERSION
  spec.authors       = ["Luca Querella"]
  spec.email         = ["lq@bendingspoons.com"]
  spec.description   = %q{Remove Podfile.lock, Pods/ and *.xcworkspace.}
  spec.summary       = %q{This command will simply remove Podfile.lock, Pods/ and *.xcworkspace from the current project.}
  spec.homepage      = "https://github.com/EXAMPLE/cocoapods-clean"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
