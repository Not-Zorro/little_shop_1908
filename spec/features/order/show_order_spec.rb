require "rails_helper"

RSpec.describe "Order Show page" do
  describe "As a visitor" do
    it "I should see a summary of my order" do
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
   
      order_1 = Order.last
 
      expect(current_path).to eq("/order/#{order_1.id}")
      within ('.customer-info-section') do
        expect(page).to have_content("Hill Stew")
        expect(page).to have_content("123 Cranberry Dr")
        expect(page).to have_content("Denver, Colorado 80210")
      end

      within ("#item-order-#{order_1.item_orders.first.id}") do
        expect(page).to have_content(pull_toy.name)
        expect(page).to have_content(pull_toy.price)
        expect(page).to have_content(pull_toy.merchant.name)
        expect(page).to have_content("1")
        expect(page).to have_content("10")
      end

      expect(page).to have_content("$50")
      expect(page).to have_content("Order placed on: #{order_1.date}")
    end
  end
end