class Turn < ApplicationRecord
  belongs_to :player

  validates :word, length: { minimum: 1, maximum: 7 }
end
