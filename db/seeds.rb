# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require './app/assets/images/image_paths.rb'
Merchant.destroy_all
Item.destroy_all

#merchants
eric = Merchant.create(name: "Eric's Hawaiian Shirt Shop", address: '123 Aloha Rd.', city: 'Denver', state: 'CO', zip: 80203)
leiya = Merchant.create(name: "Leiya's Flannel Shirt Shop", address: '56 Winter St.', city: 'Denver', state: 'CO', zip: 80210)
hill = Merchant.create(name: "Hill's Cranberry Shop", address: '90 Tuesday St.', city: 'Denver', state: 'CO', zip: 80210)

#eric items
blue_legend = eric.items.create(name: "Pacific Legend Plumeria Hibiscus - Blue", description: "Authentic Hawaiian shirts made in Honolulu, Hawaii by Pacific Legend. Our shirts are made with 100% cotton, with a spread collar and cool, lightweight fabric. Short sleeve, collared shirt with full cut neckline. The quality of our shirt is demonstrated by our pattern matching pockets. Each pocket is specifically cut to match the print of the shirt. Buttons are made from genuine coconut shells. Machine washable but allow for shrinkage when choosing sizes. You’ll be in awe of how fun and colorful these shirts really are.", price: 25, image: "https://images-na.ssl-images-amazon.com/images/I/71fpS-ExLfL._UY879_.jpg", inventory: 25)
navy_legend = eric.items.create(name: "Pacific Legend Plumeria Hibiscus - Navy", description: "Authentic Hawaiian shirts made in Honolulu, Hawaii by Pacific Legend. Our shirts are made with 100% cotton, with a spread collar and cool, lightweight fabric. Short sleeve, collared shirt with full cut neckline. The quality of our shirt is demonstrated by our pattern matching pockets. Each pocket is specifically cut to match the print of the shirt. Buttons are made from genuine coconut shells. Machine washable but allow for shrinkage when choosing sizes. You’ll be in awe of how fun and colorful these shirts really are.", price: 25, image: "https://images-na.ssl-images-amazon.com/images/I/71gZpFYnp-L._SY879._SX._UX._SY._UY_.jpg", inventory: 5)
grey_quiksilver = eric.items.create(name: "Pacific Legend Plumeria Hibiscus - Navy", description: "Authentic Hawaiian shirts made in Honolulu, Hawaii by Pacific Legend. Our shirts are made with 100% cotton, with a spread collar and cool, lightweight fabric. Short sleeve, collared shirt with full cut neckline. The quality of our shirt is demonstrated by our pattern matching pockets. Each pocket is specifically cut to match the print of the shirt. Buttons are made from genuine coconut shells. Machine washable but allow for shrinkage when choosing sizes. You’ll be in awe of how fun and colorful these shirts really are.", price: 25, image: "https://cdni.llbean.net/is/image/wim/273137_671_41?hei=302&wid=265", inventory: 5)

#leiya items
w_flannel_1 = leiya.items.create(name: "Black Stewart Tartan", description: "Scotch Plaid Flannel Shirt, Relaxed", price: 24, image: @images["1"] , inventory: 32)
w_flannel_2 = leiya.items.create(name: "Black Watch", description: "Scotch Plaid Flannel Shirt, Relaxed", price: 24, image: "https://cdni.llbean.net/is/image/wim/273137_671_41?hei=302&wid=265", inventory: 21)

#hill items 
w_flannel_1.reviews.create(title: "Ok, didn't fit that great", content: "It never broke!", rating: 5)
w_flannel_1.reviews.create(title: "Wurst Chain", content: "It broke :(", rating: 5)
w_flannel_1.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 5)
w_flannel_1.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
w_flannel_1.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)

w_flannel_2.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)
w_flannel_2.reviews.create(title: "COOL :/", content: "sometimes questionable", rating: 1)
w_flannel_2.reviews.create(title: "NEAT :/", content: "lets go", rating: 1)
w_flannel_2.reviews.create(title: "NEAT :/", content: "lets go", rating: 1)

grey_quiksilver.reviews.create(title: "SUPER :/", content: "not that great", rating: 1)
grey_quiksilver.reviews.create(title: "NICE :/", content: "cool cool", rating: 3)
grey_quiksilver.reviews.create(title: "SUPER :/", content: "not that great", rating: 1)
grey_quiksilver.reviews.create(title: "SUPER :/", content: "not that great", rating: 1)
