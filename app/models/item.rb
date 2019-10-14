class Item < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  def review_average
    return 0 if reviews.empty?
    reviews.average(:rating)
  end 

  def best_reviews 
    reviews.order("rating desc")[0..2]
  end

  def worst_reviews 
    reviews.order(:rating)[0..2]
  end

  def delete_reviews 
    reviews.delete_all
  end

  def subtotal(quantity)
    price * quantity
  end
end
