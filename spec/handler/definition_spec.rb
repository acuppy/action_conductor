require "spec_helper"
require "handler/definition"

class HandleNameHandler
end

class FooBarHandler
end

module Handler
  describe Definition do
    shared_examples_for "a definition class" do
      let(:class_name) { nil }
      let(:actions) { ["foo", "bar"] }
      let(:arguments) do
        {
          handle: handle,
          actions: actions
        }
      end

      subject(:definition) { described_class.new arguments }

      before do
        arguments.update(class_name: class_name) if class_name
      end

      it { expect(definition.handle).to eq handle }
      it { expect(definition.handler).to eq handler }
      it { expect(definition.actions).to eq actions }
    end

    context "when handler class doesn't exist" do
      let(:handle) { "not_defined" }

      subject(:definition) { described_class.new handle: handle }

      it { expect { definition.handler }.to raise_error UndefinedHandler }
    end

    context "when class_name is assumed" do
      it_behaves_like "a definition class" do
        let(:handle)  { "handle_name" }
        let(:handler) { HandleNameHandler }
      end
    end

    context "when class_name is defined" do
      it_behaves_like "a definition class" do
        let(:handle)     { "handle_name" }
        let(:class_name) { "foo_bar" }
        let(:handler)    { FooBarHandler }
      end
    end
  end
end
