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
end
