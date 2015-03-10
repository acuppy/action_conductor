require "spec_helper"

describe DummyController, "Integration ActionController::Base" do
  describe ".conductor" do
    subject(:controller) { DummyController.new }

    before(:all) { DummyController.class_eval { conductor :test_multi_export } }

    it { expect(subject).to respond_to :conductor }
    it { expect(subject).to respond_to :exports }

    context "when exporting" do
      before  { controller.index }

      context "@foo" do
        subject { controller.instance_variable_get :@foo }
        it { is_expected.to eq "Hello World" }
      end

      context "@foo_a" do
        subject { controller.instance_variable_get :@foo_a }
        it { is_expected.to eq "Hello World" }
      end

      context "@foo_b" do
        subject { controller.instance_variable_get :@foo_b }
        it { is_expected.to eq "Hello World" }
      end

      context "@bar" do
        subject { controller.instance_variable_get :@bar }
        it { is_expected.to eq "Goodbye Moon" }
      end

      context "@bar_a" do
        subject { controller.instance_variable_get :@bar_a }
        it { is_expected.to eq "Goodbye Moon" }
      end

      context "@bar_b" do
        subject { controller.instance_variable_get :@bar_b }
        it { is_expected.to eq "Goodbye Moon" }
      end

      context "@meme" do
        subject { controller.instance_variable_get :@meme }
        it { is_expected.to eq "Me me" }
      end

      context "@omg" do
        subject { controller.instance_variable_get :@omg }
        it { is_expected.to eq "LMAO..." }
      end

      context "@my_method" do
        subject { controller.instance_variable_get :@my_method }
        it { is_expected.to eq "conductor method called" }
      end
    end
  end
end
