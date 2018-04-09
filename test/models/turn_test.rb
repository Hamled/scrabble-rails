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

    it "must be invalid with no word" do
      turn.word = nil
      value(turn).wont_be :valid?

      turn.word = ''
      value(turn).wont_be :valid?
    end

    it "must have a maximum of 7 letters" do
      turn.word += 'S'
      value(turn.word.length).must_be :>, 7 # Sanity check

      value(turn).wont_be :valid?
    end
  end
end
