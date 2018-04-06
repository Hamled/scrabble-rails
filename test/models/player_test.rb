require "test_helper"

describe Player do
  let(:player) { players(:empty_rack) }
  let(:full_player) { players(:full_rack) }

  describe "attributes" do
    it "must have a name" do
      value(player).must_respond_to :name
    end

    it "must have a tile rack" do
      value(player).must_respond_to :tile_rack
    end
  end

  describe "validations" do
    it "must be valid with an empty tile rack" do
      value(player).must_be :valid?
    end

    it "must be valid with a full tile rack" do
      value(full_player).must_be :valid?
    end

    it "must be invalid without a name" do
      player.name = nil
      value(player).wont_be :valid?
    end

    it "must be invalid without a tile rack" do
      player.tile_rack = nil
      value(player).wont_be :valid?
    end

    it "must have a maximum of 7 tiles in its tile rack" do
      # Sanity check
      value(full_player.tile_rack.length).must_equal 7

      full_player.tile_rack += 'A'

      value(full_player).wont_be :valid?
    end

    it "must have only letters in its tile rack" do
      full_player.tile_rack = 'ABC123'

      value(full_player).wont_be :valid?
    end
  end
end
