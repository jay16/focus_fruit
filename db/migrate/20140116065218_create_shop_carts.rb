class CreateShopCarts < ActiveRecord::Migration
  def change
    create_table :shop_carts do |t|
      t.string :weixin
      t.string :idstr
      t.text :session

      t.timestamps
    end
  end
end
