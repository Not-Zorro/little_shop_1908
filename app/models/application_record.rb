class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def has_orders?
    !item_orders.joins(:item).empty?
  end
end
