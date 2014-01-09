class CreateFruitWithZones < ActiveRecord::Migration
  def change
    create_table :fruit_with_zones do |t|
      t.integer :fruit_id
      t.integer :fruit_zone_id

      t.timestamps
    end
  end
end
