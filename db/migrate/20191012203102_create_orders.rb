class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :token
      t.decimal :grand_total
      
      t.timestamps
    end
  end
end
