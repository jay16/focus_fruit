#encoding: utf-8
class FruitZonesController < ApplicationController
  before_filter :find_fruit_zone, :only => [:show, :edit, :udpate, :destroy]

  def index
    @fruit_zones = FruitZone.all
    @order = Order.new
    @order.weixin = (params[:weixin] || "false")
  end 

  def admin
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def upload
    allow_files = [".xls",".csv"]
    xls_file = params[:file_url]
    file_name = xls_file.original_filename.to_s
    if allow_files.include? File.extname(file_name.downcase)
      @file_path = "#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}_-_#{file_name}"
      @file_path = Rails.root.join("public", "uploads", @file_path)
      File.open(@file_path, "wb") do |file|
	file.write(xls_file.read)
      end
      parse_xls(@file_path)
    end
  end

  private
  def parse_xls(file_path)
    book = Spreadsheet.open(file_path)
    sheet1 = book.worksheet 0

    sheet1.each do |row|
      name  = row[0].to_s.chomp
      unit  = row[1].to_s.chomp
      desc1 = row[2].to_s.chomp
      price = row[3].to_s.chomp
      zone  = row[4].to_s.chomp
      desc2 = row[5].to_s.chomp

      fruit_zone = FruitZone.find_or_create_by_name(zone)
      fruit_zone.update_attribute(:desc, desc2) if desc2
      fruit = fruit_zone.fruits.find_by_name(name)
      fruit = fruit_zone.fruits.create({
        :name => name,
	:desc => desc1,
	:price => price
      }) unless fruit
    end if sheet1
  end

  def find_fruit_zone
    @fruit_zone = FruitZone.find(params[:id])
  end
end
