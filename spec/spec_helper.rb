$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "rails"
require "action_controller"
require 'handler'
require "pry"

class DummyController < ActionController::Base
end
