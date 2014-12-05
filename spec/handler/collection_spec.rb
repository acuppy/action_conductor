require "spec_helper"

module Handler
  describe Collection do
    let(:handler_of_foo) { double(:handler_of_foo, exports: ->{ "FOOBAR" } ) }
    let(:handler_of_omg) { double(:handler_of_omg, exports: ->{ "OMG!" }  )  }
    let(:handlers) { [handler_of_foo] }

    it { expect(subject.handlers).to be_a_kind_of Hash }

    describe "#exports" do
      let(:action) { "foo" }

      before do
        subject[action] << handler_of_foo
        subject[action] << handler_of_omg
      end

      it { expect(subject.exports).to eq ["FOOBAR", "OMG!"] }
    end
  end
end
