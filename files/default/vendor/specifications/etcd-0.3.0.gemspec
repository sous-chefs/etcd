# -*- encoding: utf-8 -*-
# stub: etcd 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "etcd"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ranjib Dey"]
  s.date = "2015-03-31"
  s.description = "Ruby client library for etcd"
  s.email = ["ranjib@pagerduty.com"]
  s.homepage = "https://github.com/ranjib/etcd-ruby"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9")
  s.rubygems_version = "2.4.5.1"
  s.summary = "Ruby client library for etcd"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mixlib-log>, [">= 0"])
      s.add_development_dependency(%q<uuid>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<mixlib-log>, [">= 0"])
      s.add_dependency(%q<uuid>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<mixlib-log>, [">= 0"])
    s.add_dependency(%q<uuid>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
