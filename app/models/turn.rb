class Turn < ApplicationRecord
  belongs_to :player

  validates :word, length: { minimum: 1, maximum: 7 }

  LETTER_SCORES = {
    'A' => 1, 'B' => 3, 'C' => 3, 'D' => 2, 'E' =>  1, 'F' => 4,
    'G' => 2, 'H' => 4, 'I' => 1, 'J' => 8, 'K' =>  5, 'L' => 1,
    'M' => 3, 'N' => 1, 'O' => 1, 'P' => 3, 'Q' => 10, 'R' => 1,
    'S' => 1, 'T' => 1, 'U' => 1, 'V' => 4, 'W' =>  4, 'X' => 8,
    'Y' => 4, 'Z' => 10
  }

  def score
    return nil unless word.present?

    starting_score = word.length == 7 ? 50 : 0
    word.chars.reduce(starting_score) do |word_score, letter|
      letter_score = LETTER_SCORES[letter]
      return nil if letter_score.nil?

      word_score + letter_score
    end
  end

  # Class method instead of a scope because this does not return a relation
  def self.highest_scoring
    all.reduce do |best_turn, turn|
      if turn.score > best_turn.score
        turn
      elsif best_turn.score > turn.score
        best_turn
      else
        # Tie-breaking logic
        best_len = best_turn.word.length
        turn_len = turn.word.length

        if best_len == 7
          best_turn
        elsif turn_len == 7
          turn
        elsif best_len == turn_len
          best_turn
        else
          [best_turn, turn].min_by { |t| t.word.length }
        end
      end
    end
  end
end
