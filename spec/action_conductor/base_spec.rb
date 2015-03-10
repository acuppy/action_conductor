require "spec_helper"
require "action_conductor/base"

module ActionConductor
  describe Base do
    let(:controller) { double :controller, params: {} }
    subject(:base) { Base.new(controller) }
  end
end
