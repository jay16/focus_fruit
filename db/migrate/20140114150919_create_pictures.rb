class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.text :desc
      t.string :store
      t.integer :folder_id

      t.timestamps
    end
  end
end
