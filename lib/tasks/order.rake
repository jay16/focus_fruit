namespace :order do
  task :order_list => :environment do
    Order.all.each do |order|
      order.update_attribute(:order_list, order.items.to_s)
      puts order.order_list
    end
  end
end
