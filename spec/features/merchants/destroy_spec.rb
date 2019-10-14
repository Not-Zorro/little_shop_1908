require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 11234)
  end

  describe "When I visit a merchant show page" do
    it "I can delete a merchant" do
      visit "merchants/#{@bike_shop.id}"
      click_on "Delete Merchant"
      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "I can delete a merchant that has items" do
      item = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      visit "/merchants/#{item.merchant_id}"

      click_on "Delete Merchant"
      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "I cannot delete a merchant with ordered items" do
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

      within "#item-#{tire.id}" do
        click_button 'Add to cart'
      end

      visit '/cart'

      click_link "Proceed to checkout"

      fill_in :name, with: "Hill Stew"
      fill_in :address, with: "123 Cranberry Dr"
      fill_in :city, with: "Denver"
      fill_in :state, with: "Colorado"
      fill_in :zip, with: "80210"

      click_button "Order"

      order = Order.last

      visit "/merchants/#{meg.id}"

      expect(page).to_not have_button("Delete Merchant")
    end
  end
end
