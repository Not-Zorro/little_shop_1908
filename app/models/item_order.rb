class ItemOrder < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def item_info
    item_details = Hash.new
    item = find_item
    item_details[:name] = item.name
    item_details[:merchant] = item.merchant
    item_details[:price] = item.price

    item_details
  end

  def find_item
    Item.find(self.item_id)
  end
end