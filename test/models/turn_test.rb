require "test_helper"

describe Turn do
  let(:turn) { turns(:angie_one) }

  describe "attributes" do
    it "must have a player" do
      value(turn).must_respond_to :player
    end

    it "must have a word" do
      value(turn).must_respond_to :word
    end
  end

  describe "validations" do
    it "must be valid with a valid word" do
      value(turn).must_be :valid?
    end
  end
end
