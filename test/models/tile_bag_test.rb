require "test_helper"

describe TileBag do
  let(:empty_bag) { tile_bags(:empty) }
  let(:full_bag) { tile_bags(:full) }

  describe "attributes" do
    it "must have a tiles attribute" do
      empty_bag.must_respond_to :tiles
    end
  end

  describe "validations" do
    it "must be valid for empty bag" do
      value(empty_bag).must_be :valid?
    end

    it "must be valid for full bag" do
      value(full_bag).must_be :valid?
    end

    it "must be invalid with non-letter characters" do
      value(tile_bags(:non_letters)).wont_be :valid?
    end
  end

  describe "#tiles" do
    it "starts with a full set of tiles by default" do
      bag = TileBag.create!

      value(bag.tiles).must_equal full_bag.tiles
    end
  end

  describe "#shake!" do
    it "reorders the tiles in the bag" do
      orig_tiles = full_bag.tiles.dup

      full_bag.shake!

      # There is a chance this test could have a false negative
      # if the actual result of randomly reordering the tiles
      # matches the origin ordering
      value(full_bag.tiles).wont_equal orig_tiles

      value(full_bag.tiles.chars.sort.join).must_equal orig_tiles.chars.sort.join
    end
  end

  describe "#draw!" do
    let(:num_tiles) { rand(1..7) }

    it "returns a string with N letters" do
      result = full_bag.draw!(num_tiles)

      value(result).must_be_kind_of String
      value(result.length).must_equal num_tiles

      value(result).must_match /^[A-Z]+$/
    end

    it "removes each returned tile from the bag" do
      orig_tiles = full_bag.tiles.dup

      result = full_bag.draw!(num_tiles)

      # It must have removed N tiles from the bag
      value(full_bag.tiles.length).must_equal orig_tiles.length - result.length

      # The tiles it removed are exactly the tiles that were returned
      value((full_bag.tiles.chars + result.chars).sort).must_equal orig_tiles.chars.sort
    end

    it "returns fewer tiles when there are not enough tiles" do
      # First draw enough tiles from a full bag to have insufficient numbers
      pre_draw_count = full_bag.tiles.length - num_tiles
      full_bag.draw!(pre_draw_count)

      remaining_tiles = full_bag.tiles.dup
      value(remaining_tiles.length).must_equal num_tiles # Sanity check

      # Next, draw one more than the remaining number of tiles
      result = full_bag.draw!(num_tiles + 1)

      value(result.length).must_equal num_tiles
      value(result.chars.sort).must_equal remaining_tiles.chars.sort
    end

    it "raises OutOfTilesError if there are no tiles left" do
      value(proc {
        empty_bag.draw!(1)
      }).must_raise OutOfTilesError
    end
  end
end
