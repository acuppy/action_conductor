$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "rails"
require "action_controller"
require 'handler'
require "pry"

class DummyController < ActionController::Base
  def params
    { action: :index }
  end

  def index
  end
end

class TestSingleExportHandler < Handler::Base
  export :foo, "Hello World"
end

class TestMultiExportHandler < Handler::Base
  export :foo, "Hello World"
  export :bar, "Goodbye Moon"
end

class TestMultiExportBlockHandler < Handler::Base
  export(:bar) { "Goodbye Moon" }
  export(:omg) { |lol| lol }
end
