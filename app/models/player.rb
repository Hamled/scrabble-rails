class Player < ApplicationRecord
  TILE_RACK_SIZE = 7

  has_many :turns

  # Validations
  validates :name, presence: true
  validates :tile_rack, length: { minimum: 0, maximum: TILE_RACK_SIZE }
  validate :tile_rack_must_contain_only_letters

  def full_rack?
    tile_rack.length >= TILE_RACK_SIZE
  end

  def draw_tiles!(tile_bag)
    return if full_rack?

    # shake?

    self.tile_rack += tile_bag.draw!(tiles_needed)
    save!
  rescue OutOfTilesError
  end

  private

  def tiles_needed
    return 0 if full_rack?

    TILE_RACK_SIZE - tile_rack.length
  end

  def tile_rack_must_contain_only_letters
    if /[^A-Z]/.match? tile_rack
      errors.add(:tile_rack, :invalid, message: 'must contain only letters')
    end
  end
end
