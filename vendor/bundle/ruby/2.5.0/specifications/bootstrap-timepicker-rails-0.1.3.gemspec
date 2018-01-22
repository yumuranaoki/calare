# -*- encoding: utf-8 -*-
# stub: bootstrap-timepicker-rails 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap-timepicker-rails".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pratik Khadloya".freeze]
  s.date = "2013-04-07"
  s.description = "Gemified https://github.com/jdewit/bootstrap-timepicker".freeze
  s.email = ["tispratik@gmail.com".freeze]
  s.homepage = "https://github.com/jdewit/bootstrap-timepicker".freeze
  s.rubygems_version = "2.7.3".freeze
  s.summary = "Gemified https://github.com/jdewit/bootstrap-timepicker".freeze

  s.installed_by_version = "2.7.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
