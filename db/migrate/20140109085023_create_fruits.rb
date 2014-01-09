class CreateFruits < ActiveRecord::Migration
  def change
    create_table :fruits do |t|
      t.string :name
      t.text :desc
      t.integer :inventory
      t.float :price
      t.string :state

      t.timestamps
    end
  end
end
