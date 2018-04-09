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

  describe "#score" do
    # Helper method to generate a new turn with given word
    def turn(word)
      Turn.new(player: players(:angie), word: word)
    end

    it "correctly scores simple words" do
      WORD_SCORES = {
        'DOG' => 5,
        'CAT' => 5,
        'PIG' => 6
      }

      WORD_SCORES.each do |word, score|
        value(turn(word).score).must_equal score
      end
    end

    it "adds 50 points for a 7-letter word" do
      value(turn('ACADEMY').score).must_equal 65
    end

    it "returns nil for strings containing bad characters" do
      BAD_CHAR_WORDS = ['#$%^', 'CHAR^', ' ']

      BAD_CHAR_WORDS.each do |word|
        value(turn(word).score).must_be_nil
      end
    end

    it "returns nil for words > 7 letters" do
      value(turn('abcdefgh').score).must_be_nil
    end

    it "returns nil with an empty word" do
      value(turn('').score).must_be_nil
    end
  end
end
