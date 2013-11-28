# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "two_factor_authentication"
  s.version = "0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dmitrii Golub"]
  s.date = "2013-10-30"
  s.description = "    ### Features ###\n    * control sms code pattern\n    * configure max login attempts\n    * per user level control if he really need two factor authentication\n    * your own sms logic\n"
  s.email = ["dmitrii.golub@gmail.com"]
  s.files = [".gitignore", "Gemfile", "LICENSE", "README.md", "Rakefile", "app/controllers/devise/two_factor_authentication_controller.rb", "app/views/devise/two_factor_authentication/max_login_attempts_reached.html.erb", "app/views/devise/two_factor_authentication/show.html.erb", "config/locales/en.yml", "lib/generators/active_record/templates/migration.rb", "lib/generators/active_record/two_factor_authentication_generator.rb", "lib/generators/two_factor_authentication/two_factor_authentication_generator.rb", "lib/two_factor_authentication.rb", "lib/two_factor_authentication/controllers/helpers.rb", "lib/two_factor_authentication/hooks/two_factor_authenticatable.rb", "lib/two_factor_authentication/models/two_factor_authenticatable.rb", "lib/two_factor_authentication/orm/active_record.rb", "lib/two_factor_authentication/rails.rb", "lib/two_factor_authentication/routes.rb", "lib/two_factor_authentication/schema.rb", "lib/two_factor_authentication/version.rb", "two_factor_authentication.gemspec"]
  s.homepage = "https://github.com/Houdini/two_factor_authentication"
  s.require_paths = ["lib"]
  s.rubyforge_project = "two_factor_authentication"
  s.rubygems_version = "2.0.6"
  s.summary = "Two factor authentication plugin for devise"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.1.1"])
      s.add_runtime_dependency(%q<devise>, [">= 0"])
      s.add_runtime_dependency(%q<randexp>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.1.1"])
      s.add_dependency(%q<devise>, [">= 0"])
      s.add_dependency(%q<randexp>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.1.1"])
    s.add_dependency(%q<devise>, [">= 0"])
    s.add_dependency(%q<randexp>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
  end
end
