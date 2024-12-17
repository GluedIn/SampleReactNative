# -*- encoding: utf-8 -*-
# stub: cocoapods-user-defined-build-types 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "cocoapods-user-defined-build-types".freeze
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jonathan Cardasis".freeze]
  s.date = "2020-05-04"
  s.description = "A Cocoapods plugin which selectively modifies a Pod build_type right before integration. This allows for mixing dynamic frameworks with the default static library build type used by Cocoapods.".freeze
  s.email = ["joncardasis@gmail.com".freeze]
  s.homepage = "https://github.com/joncardasis/cocoapods-user-defined-build-types".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "A Cocoapods plugin which can selectively set build type per pod (static library, dynamic framework, etc.)".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cocoapods>.freeze, [">= 1.5.0", "< 2.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<cocoapods>.freeze, [">= 1.5.0", "< 2.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<cocoapods>.freeze, [">= 1.5.0", "< 2.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
