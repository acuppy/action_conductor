require "spec_helper"

module Handler
  describe Exporter do
    let(:controller) { double(:controller, params: {})}
    let(:export_arguments) { [] }

    subject(:exporter) do
      Handler::Exporter.new(handler, export_arguments)
    end

    describe "#exports" do
      context "with one export and no arguments" do
        let(:handler) { TestSingleExportHandler.new(controller) }
        subject { exporter.export }

        it { is_expected.to eq "Hello World" }
      end

      context "with multi-export and no arguments" do
        let(:handler) { TestMultiExportHandler.new(controller) }
        subject { exporter.export }

        it { is_expected.to eq ["Hello World", "Goodbye Moon"] }
      end
    end
  end
end
