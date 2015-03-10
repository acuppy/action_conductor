require 'spec_helper'

describe ActionConductor do
  it 'has a version number' do
    expect(ActionConductor::VERSION).not_to be nil
  end

  it "binds to ActionController::Base" do
    expect(ActionController::Base.ancestors).to include(ActionConductor::ActionController)
  end
end
