class Merchant < ApplicationRecord
  has_many :items
  has_many :item_orders, through: :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def has_orders?
    !item_orders.joins(:item).empty?
  end

  def count_of_items
    items.length
  end

  def avg_item_price
    items.average(:price)
  end

  def cities_ordered
    item_orders.select(:city).uniq
  end
end
