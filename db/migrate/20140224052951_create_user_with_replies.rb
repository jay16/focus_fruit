class CreateUserWithReplies < ActiveRecord::Migration
  def change
    create_table :user_with_replies do |t|
      t.integer :user_id
      t.integer :reply_id

      t.timestamps
    end
  end
end
