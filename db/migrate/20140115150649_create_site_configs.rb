class CreateSiteConfigs < ActiveRecord::Migration
  def change
    create_table :site_configs do |t|
      t.string :domain
      t.string :title
      t.string :author
      t.text :desc
      t.string :weixin_token
      t.string :email

      t.timestamps
    end
  end
end
