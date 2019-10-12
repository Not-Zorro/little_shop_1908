require 'rails_helper'

describe ItemOrder, type: :model do
  describe "relationships" do
    it { should belong_to :item }
    it { should belong_to :order }
  end
end