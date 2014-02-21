class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :name
      t.string :email
      t.text :content
      t.text :markdown

      t.timestamps
    end
  end
end
