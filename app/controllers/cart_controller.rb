class CartController < ApplicationController
  def index
    @items = cart.cart_items
  end

  def update
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    session[:cart] = cart.contents
    flash[:notice] = "Item added to cart"
    redirect_to '/items'
  end

  def empty
    cart.empty_cart
    session[:cart] = cart.contents
    redirect_to '/cart'
  end

  def delete_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def update_item
    if params[:type] == "add_item"
      cart.increase_quantity(params[:item_id])
    elsif params[:type] == "subtract_item"
      cart.decrease_quantity(params[:item_id])
    end

    redirect_to '/cart'
  end
end
