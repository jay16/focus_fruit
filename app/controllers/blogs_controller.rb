#encoding: utf-8
class BlogsController < ApplicationController
  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  def list
    @blogs = Blog.where("klass in ('distribution','call-center','payment')")
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end

  def distribution
    @blog = Blog.find_by_klass("distribution")
    render "show"
  end

  def payment
    @blog = Blog.find_by_klass("payment")
    render "show"
  end

  def callcenter
    @blog = Blog.find_by_klass("call-center")
    render "show"
  end

  def images
    @blog = Blog.find(params[:id])
    @pictures =  @blog.pictures

    respond_to do |format|
      format.html { render layout: "layouts/application" }
    end
  end

  def upload
    @blog = Blog.find(params[:id])
    deal_with_local(@blog)    
  end

  # GET /blogs/new
  # GET /blogs/new.json
  def new
    @blog = Blog.new
    @blog.author = "水果达人"
  
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.update_attributes(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def blog_params
      params.require(:blog).permit(:author, :content, :markdown, :link, :title, :klass)
    end


    def deal_with_local(blog)
      (0..50).each_with_index do |i,index|
	key = "file_#{i}"
	next if params[key].nil?

	image = params[key]

	original_name = image.original_filename.to_s
	image_name   = chk_image_name(original_name)
	image_path = Rails.root.join("public","pictures","blog")

	FileUtils.mkdir_p(image_path) unless File.exist?(image_path)

	image_path = File.join(image_path, image_name)
	File.open(image_path, "wb") { |f| f.write(image.read) }

	picture = blog.pictures.create({
	 :name => original_name,
	 :desc => original_name,
	 :store => image_name
	 })
      end
    end
    def chk_image_name(str)
      types = %w(.jpg .jpeg .png .bmp .gif .ico).select { |d| str.downcase.include?(d) }
      type = (types.empty? ? ".jpg" : types[0])

      name = UUIDTools::UUID.md5_create(UUIDTools::UUID_DNS_NAMESPACE, str+Time.now.to_s).to_s
      return (name+type)
    end
end
