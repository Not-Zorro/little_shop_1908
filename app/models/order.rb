class Order < ApplicationRecord
  has_many :item_orders
  has_many :items, through: :item_orders

  def self.token
    SecureRandom.hex(5)
  end
end