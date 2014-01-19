class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :idstr
      t.string :name
      t.string :phone
      t.string :address
      t.string :text1
      t.string :text2
      t.string :text3
      t.string :text4
      t.string :text5

      t.timestamps
    end
  end
end
