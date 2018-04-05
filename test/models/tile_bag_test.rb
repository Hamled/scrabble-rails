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
end
