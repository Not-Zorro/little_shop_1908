require 'rails_helper'

RSpec.describe 'Create Order Spec' do
  describe "When I click Create Order" do
    it "creates an order and redirected to order show page" do
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

      fill_in :name, with: "Hill Stew"
      fill_in :address, with: "123 Cranberry Dr"
      fill_in :city, with: "Denver"
      fill_in :state, with: "Colorado"
      fill_in :zip, with: "80210"

      click_button "Order"
    end
  end
end