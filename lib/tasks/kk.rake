#encoding: utf-8
desc "build_order_with_customers"
namespace :kk do 

  desc "从订单中摘取用记信息"
  task :customer => :environment do 
    Order.all.each do |order|
      if (customers = Customer.where("idstr='#{order.weixin}' and phone='#{order.phone}' and address='#{order.address}'")).length > 0
        puts "build"
         customer = customers.order("created_at desc").first
         OrderWithCustomer.create({
	   :order_id    => order.id,
	   :customer_id => customer.id
	 })
      else
        puts "create"
        order.customers.create({
	  :idstr => order.weixin,
	  :name  => order.name,
	  :phone => order.phone,
	  :address => order.address
	})
      end
    end
  end

  #Rake::Task["solife:ip_map:update_count"].invoke

end
