ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "codeclimate-test-reporter"

CodeClimate::TestReporter.start

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end
