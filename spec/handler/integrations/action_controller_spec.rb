require "spec_helper"

class FooHandler < Handler::Base
end

describe DummyController, "Integration ActionController::Base" do
  describe ".handler" do
    before { described_class.class_eval { handler :foo } }

    it { expect(controller).to be_handled }
  end
end
