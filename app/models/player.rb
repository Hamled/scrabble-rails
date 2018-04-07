class Player < ApplicationRecord
  TILE_RACK_SIZE = 7

  # Validations
  validates :name, presence: true
  validates :tile_rack, length: { minimum: 0, maximum: TILE_RACK_SIZE }
  validate :tile_rack_must_contain_only_letters

  def full_rack?
    tile_rack.length >= TILE_RACK_SIZE
  end

  private

  def tile_rack_must_contain_only_letters
    if /[^A-Z]/.match? tile_rack
      errors.add(:tile_rack, :invalid, message: 'must contain only letters')
    end
  end
end
