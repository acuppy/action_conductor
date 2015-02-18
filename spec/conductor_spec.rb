require 'spec_helper'

describe Conductor do
  it 'has a version number' do
    expect(Conductor::VERSION).not_to be nil
  end

  it "binds to ActionController::Base" do
    expect(ActionController::Base.ancestors).to include(Conductor::ActionController)
  end
end
