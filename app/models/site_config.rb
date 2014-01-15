class SiteConfig < ActiveRecord::Base
  attr_accessible :author, :desc, :domain, :email, :title, :weixin_token
end
