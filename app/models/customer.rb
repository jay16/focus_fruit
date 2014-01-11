class Customer < ActiveRecord::Base
  attr_accessible :address, :name, :phone, :remark, :weixin
end
