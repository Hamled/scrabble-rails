class Player < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :tile_rack, length: { minimum: 0, maximum: 7 }
  validate :tile_rack_must_contain_only_letters

  private

  def tile_rack_must_contain_only_letters
    if /[^A-Z]/.match? tile_rack
      errors.add(:tile_rack, :invalid, message: 'must contain only letters')
    end
  end
end
