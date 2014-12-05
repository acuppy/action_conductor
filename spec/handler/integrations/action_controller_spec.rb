require "spec_helper"

describe DummyController, "Integration ActionController::Base" do
  describe ".handler" do
    before  { DummyController.class_eval { handler :test_single_export } }
    subject { DummyController.new }

    it { expect(subject).to respond_to :handler }
  end
end
