require 'rubygems'
require 'bundler/setup'
require "rails"
require "devise"
require "devise_login_cookie"
require "action_dispatch/middleware/cookies"
require 'capybara/rspec'
require 'capybara-webkit'
require 'capybara/webkit/matchers'
require 'show_me_the_cookies'


ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../spec/dummy/config/environment", __FILE__)
ActiveRecord::Migrator.migrate(File.expand_path("../dummy/db/migrate/", __FILE__))

require 'rspec/rails'
Capybara.app = Dummy::Application

Capybara.javascript_driver = :webkit
Capybara.server_port = 5000


RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.include(Capybara::Webkit::RspecMatchers, type: :feature)
  config.include(Capybara::DSL)
  config.include ShowMeTheCookies
end


module DeviseLoginCookie

  module SpecHelpers

    def resource(id)
      require "ostruct"
      OpenStruct.new(:id => id)
    end

    def cookie_jar(cookies = {})
      key = "aa" * 20
      ActionDispatch::Cookies::CookieJar.new(key).tap do |jar|
        cookies.each { |key, value| jar[key] = value }
      end
    end

    def create_cookie(cookies = {})
      Cookie.new(cookie_jar(cookies), :test).tap do |cookie|
        cookie.session_options = {}
      end
    end

    def create_valid_cookie(id, created_at)
      create_cookie :test_token => signed_cookie_value(id, created_at.to_i)
    end

    def signed_cookie_value(id, created_at)
      key = "aa" * 20
      jar = ActionDispatch::Cookies::CookieJar.new(key)
      jar.signed[:test_token] = {value: [id, created_at]}
      jar[:test_token]
    end

  end

end

def login(email = nil, password = nil)
  fill_in "Email", with: email || 'test@example.com'
  fill_in "Password", with: password || 'test'
  click_on "Sign in"
end

def cookies
  page.driver.request.cookies
end
