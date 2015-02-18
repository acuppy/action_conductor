require "spec_helper"
require "conductor/base"

module Conductor
  describe Base do
    let(:controller) { double :controller, params: {} }
    subject(:base) { Base.new(controller) }
  end
end
