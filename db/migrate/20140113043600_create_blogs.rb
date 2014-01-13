class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :type
      t.string :author
      t.string :link
      t.text :content
      t.text :markdown

      t.timestamps
    end
  end
end
