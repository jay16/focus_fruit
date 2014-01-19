class CreateOrderWithCustomers < ActiveRecord::Migration
  def change
    create_table :order_with_customers do |t|
      t.integer :order_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
