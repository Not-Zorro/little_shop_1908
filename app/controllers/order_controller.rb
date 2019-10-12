class OrderController < ApplicationController
  def index
    @items = cart.cart_items
  end
end
