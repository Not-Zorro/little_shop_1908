require 'rails_helper'

describe Cart, type: :model do
  describe "initialize" do
    it "has contents" do
      hash = {
        "1" => 2,
        "2" => 3
      }
      cart = Cart.new({})
      expect(cart.contents).to eq({})
      cart_2 = Cart.new(hash)
      expect(cart_2.contents).to eq(hash)
    end
  end

  describe "methods" do
    it "can do all cart methods" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      pull_toy = meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      dog_bone = meg.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)

      hash = {
        tire.id => 2,
        pull_toy.id => 3
      }

      cart = Cart.new(hash)

      cart.increase_quantity(tire.id)
      expect(cart.contents).to eq({
        tire.id => 3,
        pull_toy.id => 3
      })

      expect(cart.total_items).to eq(6)

      expect(cart.cart_items).to eq({
        tire => 3,
        pull_toy => 3
      })

      expect(cart.grand_total).to eq(330)
      cart.add_item(dog_bone.id)
      expect(cart.contents).to eq({
        tire.id => 3,
        pull_toy.id => 3,
        dog_bone.id => 1
      })

      cart.decrease_quantity(tire.id)
      expect(cart.contents).to eq({
        tire.id => 2,
        pull_toy.id => 3,
        dog_bone.id => 1
      })
      expect(cart.empty_cart).to eq({})
    end
  end
end
