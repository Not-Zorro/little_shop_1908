require 'rails_helper'

describe "New order page" do
    # As a visitor
    # When I check out from my cart
    # On the new order page I see the details of my cart:
    # - the name of the item
    # - the merchant I'm buying this item from
    # - the price of the item
    # - my desired quantity of the item
    # - a subtotal (price multiplied by quantity)
    # - a grand total of what everything in my cart will cost
    # I also see a form to where I must enter my shipping information for the order:
    # - name
    # - address
    # - city
    # - state
    # - zip
    # I also see a button to 'Create Order'
  it "can show info about order" do
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)

    visit '/items'

    within "#item-#{pull_toy.id}" do
      click_button 'Add to cart'
    end

    within "#item-#{dog_bone.id}" do
      click_button 'Add to cart'
      click_button 'Add to cart'
    end

    visit '/cart'

    click_link "Proceed to checkout"

    within "#item-order-#{pull_toy.id}" do
      expect(page).to have_content(pull_toy.name)
      expect(page).to have_content("Price: $#{pull_toy.price}")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Sold by: #{brian.name}")
      expect(page).to have_content("Subtotal: $10")
    end

    within "#item-order-#{dog_bone.id}" do
      expect(page).to have_content(dog_bone.name)
      expect(page).to have_content("Price: $#{dog_bone.price}")
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Sold by: #{brian.name}")
      expect(page).to have_content("Subtotal: $40")
    end

    within ".order-section" do
      expect(page).to have_content("Grand total: $50")
      has_button?('Order')
    end
  end
end
