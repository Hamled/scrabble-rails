class Player < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :tile_rack, length: { minimum: 0, maximum: 7 }
end
