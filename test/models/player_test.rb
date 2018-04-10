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

    it "must have a list of turns" do
      value(player).must_respond_to :turns
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

  describe "#full_rack?" do
    it "returns true when tile rack is full" do
      value(full_player.full_rack?).must_equal true
    end

    it "returns false when tile rack is not full" do
      value(player.full_rack?).must_equal false

      "ABCDEF".chars.each do |letter|
        player.tile_rack += letter
        value(player.full_rack?).must_equal false
      end
    end
  end

  describe "#draw_tiles!" do
    let(:empty_bag) { tile_bags(:empty) }
    let(:full_bag) { tile_bags(:full) }

    # Since our tile rack is only up to 7 tiles we can produce a
    # comprehensive suite of tests for all tile rack states
    7.times do |start_count|
      it "removes enough tiles to have a full rack (#{start_count}/7)" do
        # Store a copy of the original bag tiles for later verification
        orig_tiles = full_bag.tiles.dup.chars

        # Give the player a beginning set of tiles
        player.tile_rack += "A" * start_count
        value(player.full_rack?).must_equal false # Sanity check

        player.draw_tiles!(full_bag)

        player_tiles = player.tile_rack.chars
        drawn_tiles = player_tiles[start_count..-1]
        remaining_tiles = full_bag.tiles.chars

        value((drawn_tiles + remaining_tiles).sort).must_equal orig_tiles.sort
        value(player.full_rack?).must_equal true
      end

      it "doesn't remove any tiles from an empty bag (#{start_count}/7)" do
        value(empty_bag.tiles.blank?).must_equal true # Sanity check

        # Give the player a beginning set of tiles
        player.tile_rack += "A" * start_count
        value(player.full_rack?).must_equal false # Sanity check
        orig_rack = player.tile_rack.dup

        player.draw_tiles!(empty_bag)

        value(empty_bag.tiles.blank?).must_equal true
        value(player.tile_rack).must_equal orig_rack
      end
    end

    it "doesn't remove any tiles with a full rack" do
      orig_tiles = full_bag.tiles.dup.chars
      value(full_player.full_rack?).must_equal true # Sanity check

      full_player.draw_tiles!(full_bag)

      value(full_bag.tiles.chars.sort).must_equal orig_tiles.sort
      value(full_player.full_rack?).must_equal true
    end

    it "doesn't remove any tiles from an empty bag with a full rack" do
      value(empty_bag.tiles.blank?).must_equal true # Sanity check
      orig_rack = full_player.tile_rack.dup

      full_player.draw_tiles!(empty_bag)

      value(empty_bag.tiles.blank?).must_equal true
      value(full_player.tile_rack).must_equal orig_rack
    end
  end

  describe "#play!" do
    let(:angie) { players(:angie) }

    it "plays the given word by creating a new turn with that word" do
      num_turns = angie.turns.count

      angie.play!('ORCHARD')

      value(angie.turns.count).must_equal (num_turns + 1)
      value(angie.turns.last.word).must_equal 'ORCHARD'
    end

    it "removes the played tiles from the tile rack" do
      orig_rack = angie.tile_rack.dup

      angie.play!('HARD')

      value(angie.tile_rack.length).must_equal (orig_rack.length - 4)
      value((angie.tile_rack.chars + 'HARD'.chars).sort).must_equal orig_rack.chars.sort
    end

    it "raises ArgumentError for empty, non-string, or unscorable" do
      BAD_INPUTS = [nil, '', 10, '^%$', ' ', 'MUCHTOOLONG']

      BAD_INPUTS.each do |input|
        value(proc {
          angie.play!(input)
        }).must_raise ArgumentError
      end
    end

    it "raises ArgumentError for word that cannot be played" do
      value(angie.tile_rack).must_equal 'ORCHARD' # Sanity check

      value(proc {
        angie.play!('BONES')
      }).must_raise ArgumentError
    end
  end
end
