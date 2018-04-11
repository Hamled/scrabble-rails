module ApplicationHelper

  def display_word(turn)
    return "None" unless turn

    turn.word
  end
end
