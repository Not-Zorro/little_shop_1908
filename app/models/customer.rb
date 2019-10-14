class Customer
  attr_reader :name, :address, :city, :state, :zip

  def initialize(customer_details)
    @name = customer_details["name"]
    @address = customer_details["address"]
    @city = customer_details["city"]
    @state = customer_details["state"]
    @zip = customer_details["zip"]
  end
end