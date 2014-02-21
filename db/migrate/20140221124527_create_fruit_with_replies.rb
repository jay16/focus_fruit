class CreateFruitWithReplies < ActiveRecord::Migration
  def change
    create_table :fruit_with_replies do |t|
      t.integer :fruit_id
      t.integer :reply_id

      t.timestamps
    end
  end
end
