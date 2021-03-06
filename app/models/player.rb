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

  def play!(word)
    unless word.is_a?(String) && (1..TILE_RACK_SIZE).include?(word.length)
      raise ArgumentError.new('Invalid word')
    end

    new_rack = tile_rack.chars.dup
    word.chars.each do |letter|
      index = new_rack.index(letter)
      raise ArgumentError.new("Tile rack missing letter #{letter}") unless index

      new_rack.delete_at(index)
    end

    new_turn = nil
    transaction do
      self.tile_rack = new_rack.join
      new_turn = turns.create(word: word)
      save!
    end

    return new_turn
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
