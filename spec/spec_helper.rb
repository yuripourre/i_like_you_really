# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "mocha/setup"
require "omniauth"
require 'capybara/rails'
require 'capybara/rspec'
include Capybara::DSL

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.mock_with :mocha
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  OmniAuth.config.test_mode = true
  config.global_fixtures =  :all

  Capybara.configure do |config|
    config.always_include_port = true
    config.javascript_driver   = :selenium
  end
end
