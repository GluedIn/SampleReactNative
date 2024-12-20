# -*- encoding: utf-8 -*-
# stub: cocoapods-clean 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "cocoapods-clean".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Luca Querella".freeze]
  s.date = "2014-10-29"
  s.description = "Remove Podfile.lock, Pods/ and *.xcworkspace.".freeze
  s.email = ["lq@bendingspoons.com".freeze]
  s.homepage = "https://github.com/EXAMPLE/cocoapods-clean".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "This command will simply remove Podfile.lock, Pods/ and *.xcworkspace from the current project.".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
