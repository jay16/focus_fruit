class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :order_id
      t.integer :fruit_id
      t.string :name
      t.integer :count
      t.float :price

      t.timestamps
    end
  end
end
