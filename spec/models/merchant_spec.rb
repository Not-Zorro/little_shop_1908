require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :items}
  end

  describe "methods" do
    it "can do merchant methods" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      expect(meg.count_of_items).to eq(1)

      pull_toy = meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      order = Order.create(
        token: "1234567890",
        grand_total: 110
      )

      pull_toy.item_orders.create(
        quantity: 1,
        order_id: order.id,
        city: "Denver"
      )

      pull_toy.item_orders.create(
        quantity: 1,
        order_id: order.id,
        city: "Littleton"
      )

      expect(meg.count_of_items).to eq(2)
      expect(meg.avg_item_price).to eq(55)
      expect(meg.cities_ordered.length).to eq(2)
    end
  end
end
