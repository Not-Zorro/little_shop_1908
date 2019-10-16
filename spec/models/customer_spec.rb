require 'rails_helper'

describe Customer, type: :model do
  describe "customer has attributes" do
    it "can use attr_reader to call info" do
      hash = {
        "name" => "David",
        "address" => "123 Main st",
        "city" => "Denver",
        "state" => "CO",
        "zip" => "80128",
      }
      customer = Customer.new(hash)

      expect(customer.name).to eq("David")
      expect(customer.address).to eq("123 Main st")
      expect(customer.city).to eq("Denver")
      expect(customer.state).to eq("CO")
      expect(customer.zip).to eq("80128")
    end
  end
end
