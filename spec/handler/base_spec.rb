require "spec_helper"
require "handler/base"

module Handler
  describe Base do
    let(:controller) { double :controller, params: {} }
    subject(:base) { Base.new(controller) }

    it { is_expected.to respond_to :handled? }
  end
end
