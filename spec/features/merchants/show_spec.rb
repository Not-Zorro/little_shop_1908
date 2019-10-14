require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    end

    it 'I can see a merchants name, address, city, state, zip' do
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

      fill_in :name, with: "David Lopez"
      fill_in :address, with: "123 Ranberry Dr"
      fill_in :city, with: "Colorado Springs"
      fill_in :state, with: "Colorado"
      fill_in :zip, with: "80210"

      click_button "Order"

      visit "/merchants/#{brian.id}"

      expect(page).to have_content(brian.name)
      expect(page).to have_content(brian.address)
      expect(page).to have_content("#{brian.count_of_items}")
      expect(page).to have_content("#{brian.avg_item_price}")
      within "#merchant-cities" do
        expect(page).to have_content("Denver")
        expect(page).to have_content("Colorado Springs")
      end
    end

    it 'I can see a link to visit the merchant items' do
      visit "/merchants/#{@bike_shop.id}"

      expect(page).to have_link("All #{@bike_shop.name} Items")

      click_on "All #{@bike_shop.name} Items"

      expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
    end

  end
end
