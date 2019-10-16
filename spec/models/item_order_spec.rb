require 'rails_helper'

describe ItemOrder, type: :model do
  describe "relationships" do
    it { should belong_to :item }
    it { should belong_to :order }
  end


  describe "methods" do
    it "item_info" do 
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      pull_toy = meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      order = Order.create(
        token: "1234567890",
        grand_total: 110
      )
      item_order_1 = pull_toy.item_orders.create(
        quantity: 1,
        order_id: order.id,
        city: "Denver"
      )

      hash = {
        name: pull_toy.name,
        merchant: pull_toy.merchant,
        price: pull_toy.price,
        subtotal: 10
      }

      expect(item_order_1.item_info).to eq(hash)
    end

    it "can find an item" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      pull_toy = meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      order = Order.create(
        token: "1234567890",
        grand_total: 110
      )

      item_order_1 = pull_toy.item_orders.create(
        quantity: 1,
        order_id: order.id,
        city: "Denver"
      )

      pull_toy.item_orders.create(
        quantity: 1,
        order_id: order.id,
        city: "Littleton"
      )

      expect(item_order_1.find_item).to eq(pull_toy)
    end
  end
end