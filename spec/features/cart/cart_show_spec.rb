require 'rails_helper'

describe "Cart Index" do
  it "can list all items and info" do
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
    visit '/cart'

    within ".cart-section" do
      expect(page).to have_content("Your Cart is Empty")
    end

    visit '/items'

    within "#item-#{pull_toy.id}" do
      click_button 'Add to cart'
    end

    within "#item-#{dog_bone.id}" do
      click_button 'Add to cart'
      click_button 'Add to cart'
    end

    visit '/cart'

    within "#item-cart-#{pull_toy.id}" do
      expect(page).to have_content(pull_toy.name)
      expect(page).to have_content("Price: $#{pull_toy.price}")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Sold by: #{brian.name}")
      expect(page).to have_content("Subtotal: $10")
      expect(page).to have_css("img[src*='#{pull_toy.image}']")
    end

    within "#item-cart-#{dog_bone.id}" do
      expect(page).to have_content(dog_bone.name)
      expect(page).to have_content("Price: $#{dog_bone.price}")
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Sold by: #{brian.name}")
      expect(page).to have_content("Subtotal: $40")
      expect(page).to have_css("img[src*='#{dog_bone.image}']")
    end

    within ".cart-section" do
      expect(page).to have_content("Grand total: $50")
    end
  end

  it "has a link to empty cart" do
    brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
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

    within (".cart_div") do
      expect(page).to have_content("3")
    end

    click_link 'Empty Cart'

    within (".cart_div") do
      expect(page).to have_content("0")
    end
  end

  it "Can remove single items" do
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

    within "#item-cart-#{dog_bone.id}" do
      click_button 'Remove From Cart'
    end

    expect(page).to_not have_css("#item-cart-#{dog_bone.id}")

  end

  it "Add quanity to item in cart" do
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

    within "#item-cart-#{dog_bone.id}" do
      click_on(class: 'cart_add_button')
      expect(page).to have_content("Quantity: 3")
    end
  end

  it "Subtract quanity to item in cart" do
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

    within "#item-cart-#{dog_bone.id}" do
      click_on(class: 'cart_subtract_button')
      expect(page).to have_content("Quantity: 1")
      click_on(class: 'cart_subtract_button')
    end
    expect(page).to_not have_css("#item-cart-#{dog_bone.id}")
  end

  it "can link to checkout page" do
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

    expect(current_path).to eq('/cart/checkout')
  end
end
