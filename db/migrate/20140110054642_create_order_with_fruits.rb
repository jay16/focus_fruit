class CreateOrderWithFruits < ActiveRecord::Migration
  def change
    create_table :order_with_fruits do |t|
      t.integer :order_id
      t.integer :fruit_id

      t.timestamps
    end
  end
end
