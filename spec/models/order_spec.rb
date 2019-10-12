require 'rails_helper'

describe Order, type: :model do
  it { should have_many :item_orders }
  it { should have_many :items }
end
