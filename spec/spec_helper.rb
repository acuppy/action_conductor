$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "rails"
require "action_controller"
require 'action_conductor'

class DummyController < ActionController::Base
  def params
    { action: :index }
  end

  def index
    @foo = exports(:foo)
    @bar = conductor.export(:bar)
    @foo_a, @bar_a, @meme = conductor.export
    @bar_b, @foo_b = conductor.export(:bar, :foo)
    @omg = conductor.export(:omg, "LMAO")
    @my_method = conductor.export(:my_method)
  end
end

class TestMultiExportConductor < ActionConductor::Base
  export :foo, "Hello World"
  export :bar, "Goodbye Moon"

  export :meme do
    "Me me"
  end

  export :omg do |lol|
    "#{lol}..."
  end

  export :my_method do
    my_method
  end

  def my_method
    "conductor method called"
  end
end
