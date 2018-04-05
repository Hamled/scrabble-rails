class TileBag < ApplicationRecord

  # Validations
  validate :tiles_must_contain_only_letters

  private

  def tiles_must_contain_only_letters
    if /[^A-Z]/.match(tiles)
      errors.add(:tiles, :invalid, message: "must contain only letters")
    end
  end
end
