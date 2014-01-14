class CreateFruits < ActiveRecord::Migration
  def change
    create_table :fruits do |t|
      t.string :name
      t.integer :inventory
      t.float :price
      t.string :state
      t.text :desc
      t.text :markdown
      t.string :pic
      t.string :link

      t.timestamps
    end
  end
end
