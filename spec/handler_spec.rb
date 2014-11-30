require 'spec_helper'

describe Handler do
  it 'has a version number' do
    expect(Handler::VERSION).not_to be nil
  end

  it "binds to ActionController::Base" do
    expect(ActionController::Base.ancestors).to include(Handler::ActionController)
  end
end
