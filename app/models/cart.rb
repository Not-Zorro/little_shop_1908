class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents ||= Hash.new(0)
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def total_items
    @contents.values.sum
  end

  def cart_items
    items = Hash.new
    @contents.each do |item_id, quantity|
      items[Item.find(item_id)] = quantity
    end
    items
  end

  def grand_total
    cart_items.sum do |item, quantity|
     item.price * quantity
    end
  end

  def empty_cart
    @contents = Hash.new(0)
  end

  def increase_quantity(item_id)
    @contents[item_id] += 1
  end

  def decrease_quantity(item_id)
    if @contents[item_id] - 1 == 0
      @contents.delete(item_id)
    else
      @contents[item_id] -= 1
    end
  end
end
