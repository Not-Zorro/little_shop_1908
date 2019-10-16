require 'rails_helper'

describe Order, type: :model do
  describe "relationships" do
    it { should have_many :item_orders }
    it { should have_many :items }
  end

  describe "methods" do
    it "should return 10 char token" do
      expect(Order.token.length).to eq(10)
    end
  end
end
