class CreateBlogWithPictures < ActiveRecord::Migration
  def change
    create_table :blog_with_pictures do |t|
      t.integer :blog_id
      t.integer :picture_id

      t.timestamps
    end
  end
end
