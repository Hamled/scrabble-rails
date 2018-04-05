require "test_helper"

describe TileBag do
  let(:empty_bag) { tile_bags(:empty) }

  describe "attributes" do
    it "must have a tiles attribute" do
      empty_bag.must_respond_to :tiles
    end
  end

  describe "validations" do
    it "must be valid for empty bag" do
      value(empty_bag).must_be :valid?
    end
  end
end
