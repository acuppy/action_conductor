require "spec_helper"

describe DummyController, "Integration ActionController::Base" do
  describe ".conductor" do
    subject(:controller) { DummyController.new }

    before(:all) { DummyController.class_eval { conductor :test_multi_export } }

    it { expect(subject).to respond_to :conductor }
    it { expect(subject).to respond_to :exports }

    context "when exporting" do
      before  { controller.index }

      ["@foo", "@foo_a", "@foo_b"].each do |var|
        context var do
          subject { controller.instance_variable_get var.to_sym }
          it { is_expected.to eq "Hello World" }
        end
      end

      ["@bar", "@bar_a", "@bar_b"].each do |var|
        context var do
          subject { controller.instance_variable_get var.to_sym }
          it { is_expected.to eq "Goodbye Moon" }
        end
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

    context "without explicitly defining the conductor" do
    end
  end
end
