require 'securerandom'

class OrderController < ApplicationController
  def index
    @items = cart.cart_items
  end

  def create
    if !customer_params.values.include?("")
      order = Order.create(
        token: Order.token,
        grand_total: cart.grand_total
      )
      session[:customer] = customer_params
      cart.cart_items.each do |cart_item, amount|
        order.item_orders.create(
          quantity: amount,
          city: params["city"],
          order_id: order.id,
          item_id: cart_item.id
        )
      end
        cart.empty_cart
        session[:cart] = cart.contents
        redirect_to "/order/#{order.id}"
    else
      flash[:error] = "Please complete all fields."
      redirect_to "/cart/checkout"
    end
  end

  def show
    @order = Order.find(params[:order_id])
  end

  private
    def customer_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
