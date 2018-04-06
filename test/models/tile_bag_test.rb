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
end
