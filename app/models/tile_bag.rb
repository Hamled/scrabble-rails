class TileBag < ApplicationRecord

  # Validations
  validate :tiles_must_contain_only_letters

  TILE_COUNTS = {
    'A' => 9, 'B' => 2, 'C' => 2, 'D' => 4, 'E' => 12, 'F' => 2,
    'G' => 3, 'H' => 2, 'I' => 9, 'J' => 1, 'K' =>  1, 'L' => 4,
    'M' => 2, 'N' => 6, 'O' => 8, 'P' => 2, 'Q' =>  1, 'R' => 6,
    'S' => 4, 'T' => 6, 'U' => 4, 'V' => 2, 'W' =>  2, 'X' => 1,
    'Y' => 2, 'Z' => 1,
  }

  # Ensure that new tile bags start with the full set of tiles
  before_create do
    if tiles.blank?
      self.tiles = TILE_COUNTS.map { |letter, count| letter * count }.sum
    end
  end

  private

  def tiles_must_contain_only_letters
    if /[^A-Z]/.match(tiles)
      errors.add(:tiles, :invalid, message: "must contain only letters")
    end
  end
end
