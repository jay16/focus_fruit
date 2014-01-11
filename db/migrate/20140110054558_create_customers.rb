class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :weixin
      t.string :name
      t.string :phone
      t.string :address
      t.text :remark

      t.timestamps
    end
  end
end
