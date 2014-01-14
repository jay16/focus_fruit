class CreateFruitZones < ActiveRecord::Migration
  def change
    create_table :fruit_zones do |t|
      t.string :name
      t.text :desc
      t.string :state
      t.string :list

      t.timestamps
    end
  end
end
