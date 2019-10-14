class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :customer

  def cart 
    @cart ||= Cart.new(session[:cart])
  end

  def customer
    @customer ||= Customer.new(session[:customer])
  end
end
