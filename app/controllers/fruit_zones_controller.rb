#encoding: utf-8
class FruitZonesController < ApplicationController
  before_filter :find_fruit_zone, :only => [:show, :edit, :udpate, :destroy]

  def index
    @fruit_zones = FruitZone.where("state='onsale'")
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
    @fruit_zone = FruitZone.find(params[:id])
    @fruit_zone.update_attributes(params[:fruit_zone]) if @fruit_zone
  end

  def destroy
    @fruits = @fruit_zone.fruits
    @fruit_zone.destroy if @fruits.size == 0
  end

  #模板zip上传范例下载
  def download
    file_path = Rails.root.join("public","水果达人上传模板.xls")
    io = File.open(file_path)
    io.binmode
    data = io.read
    io.close

    respond_to do |format|
      format.xls {
        send_data(data,
                  :type => "text/excel;charset=utf-8; header=present",
		  :disposition => 'attachment',
                  :filename => "果达人上传模板.xls")
      }
      format.csv {
        send_data(data,
                  :type => "text/csv;charset=utf-8; header=present",
		  :disposition => 'attachment',
                  :filename => "Report_Members_#{Time.now.strftime("%Y%m%d%H%M")}.csv")
      }
    end
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

  def find_fruit_zone
    @fruit_zone = FruitZone.find(params[:id])
  end

  private

  def parse_xls(file_path)
    book = Spreadsheet.open(file_path)
    sheet1 = book.worksheet 0

    #不处理标题
    #跳过第一行
    sheet1.each 1 do |row|
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

end
