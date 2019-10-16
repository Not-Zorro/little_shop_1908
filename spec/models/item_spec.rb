require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :reviews }
    it { should have_many :item_orders }
    it { should have_many :orders }
  end

  describe "methods" do
    it "can average all reviews" do
      brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
      
      
      expect(pull_toy.review_average).to eq(0)

      pull_toy.reviews.create(title: "Ok, didn't fit that great", content: "It never broke!", rating: 4)
      pull_toy.reviews.create(title: "Wurst Chain", content: "It broke :(", rating: 2)

      expect(pull_toy.review_average).to eq(3)
    end

    it "can return best and worst reviews" do
      brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
      r1 = pull_toy.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 5)
      r2 = pull_toy.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      r3 = pull_toy.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      r4 = pull_toy.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 1)
      r5 = pull_toy.reviews.create(title: "COOL :/", content: "sometimes questionable", rating: 1)
      r6 = pull_toy.reviews.create(title: "NEAT :/", content: "lets go", rating: 1)
      
      expect(pull_toy.best_reviews).to eq([r1, r2, r3])
      expect(pull_toy.worst_reviews).to eq([r4, r5, r6])
    end

    it "can delete its reviews" do
      brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      r1 = pull_toy.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 5)
      r2 = pull_toy.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      r3 = pull_toy.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      r4 = pull_toy.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 1)
      r5 = pull_toy.reviews.create(title: "COOL :/", content: "sometimes questionable", rating: 1)
      r6 = pull_toy.reviews.create(title: "NEAT :/", content: "lets go", rating: 1)

      pull_toy.delete_reviews
      expect(pull_toy.reviews).to eq([])
    end

    it "can return a subtotal" do
      brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      expect(pull_toy.subtotal(2)).to eq(20)
    end
  end
end
