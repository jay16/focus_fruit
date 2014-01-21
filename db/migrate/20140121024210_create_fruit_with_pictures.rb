class CreateFruitWithPictures < ActiveRecord::Migration
  def change
    create_table :fruit_with_pictures do |t|
      t.integer :fruit_id
      t.integer :picture_id

      t.timestamps
    end
  end
end
