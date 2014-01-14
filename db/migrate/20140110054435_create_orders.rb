class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :weixin
      t.string :ip
      t.text :browser
      t.string :name
      t.string :phone
      t.string :address
      t.string :date_at
      t.text :remark
      t.text :info
      t.integer :count
      t.float :checkout
      t.string :state

      t.timestamps
    end
  end
end
