require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @review_1 = @chain.reviews.create(title: "Best Chain!", content: "It never broke!", rating: 5)
    @review_2 = @chain.reviews.create(title: "Wurst Chain", content: "It broke :(", rating: 5)
  end

  it 'shows item info' do
    visit "/items/#{@review_1.item.id}"

    within("#item-show-#{@review_1.item.id}") do
      expect(page).to have_link(@review_1.item.merchant.name)
      expect(page).to have_content(@review_1.item.name)
      expect(page).to have_content(@review_1.item.description)
      expect(page).to have_content("Price: $#{@review_1.item.price}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@review_1.item.inventory}")
      expect(page).to have_content("Sold by: #{@review_1.item.merchant.name}")
      expect(page).to have_css("img[src*='#{@review_1.item.image}']")
    end
  end

  it 'shows all item reviews' do
    visit "/items/#{@review_1.item.id}"

    within("#item-review-#{@review_1.id}") do
      expect(page).to have_content("Best Chain!")
      expect(page).to have_content("It never broke!")
      expect(page).to have_content('5')
    end

    within("#item-review-#{@review_2.id}") do
      expect(page).to have_content("Wurst Chain")
      expect(page).to have_content("It broke :(")
      expect(page).to have_content('5')
    end
  end

  it 'I see review statistics' do

    review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 5)
    review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
    review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)
    review_6 = @chain.reviews.create(title: "COOL :/", content: "sometimes questionable", rating: 1)
    review_7 = @chain.reviews.create(title: "NEAT :/", content: "lets go", rating: 1)
    review_8 = @chain.reviews.create(title: "SUPER :/", content: "not that great", rating: 1)
    review_9 = @chain.reviews.create(title: "NICE :/", content: "cool cool", rating: 3)
    visit "/items/#{@review_1.item.id}"

    expect(page).to have_content("Average rating: 2.9")

    within "#best-review-stats" do
      expect(page).to have_content("Best Chain!, Rating: 5")
      expect(page).to have_content("Wurst Chain, Rating: 5")
      expect(page).to have_content("Meh place, Rating: 5")
    end

    within "#worst-review-stats" do
      expect(page).to have_content("COOL :/, Rating: 1")
      expect(page).to have_content("SUPER :/, Rating: 1")
      expect(page).to have_content("NEAT :/, Rating: 1")
    end
  end
end
