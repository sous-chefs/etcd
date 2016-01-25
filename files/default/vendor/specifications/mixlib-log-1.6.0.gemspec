# -*- encoding: utf-8 -*-
# stub: mixlib-log 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mixlib-log"
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Opscode, Inc."]
  s.date = "2013-04-02"
  s.email = "info@opscode.com"
  s.extra_rdoc_files = ["README.rdoc", "LICENSE", "NOTICE"]
  s.files = ["LICENSE", "NOTICE", "README.rdoc"]
  s.homepage = "http://www.opscode.com"
  s.rubygems_version = "2.4.5.1"
  s.summary = "A gem that provides a simple mixin for log functionality"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.10"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.10"])
      s.add_dependency(%q<cucumber>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.10"])
    s.add_dependency(%q<cucumber>, [">= 0"])
  end
end
