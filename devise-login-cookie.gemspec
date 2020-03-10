# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise_login_cookie/version"

Gem::Specification.new do |s|
  s.name        = "devise-login-cookie"
  s.version     = DeviseLoginCookie::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Annesley"]
  s.email       = ["paul@annesley.cc"]
  s.homepage    = "http://rubygems.org/gems/devise-login-cookie"
  s.summary     = %q{Devise extension which sets a login cookie, for easier sharing of login between applications}
  s.description = %q{Devise sets a "remember_token" cookie for Remember Me logins, but not for standard logins.  This extension sets a separate cookie on login, which makes sharing login state between same-domain web applications easier.}

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/jobseekerltd'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  s.rubyforge_project = "devise-login-cookie"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("devise")

  s.add_development_dependency("rspec", ["~> 2.2"])
  s.add_development_dependency("activesupport") # devise requires this
  s.add_development_dependency("rails")
  s.add_development_dependency("capybara")
  s.add_development_dependency("pry-byebug")
  s.add_development_dependency("capybara-webkit")
  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "show_me_the_cookies"

end
