#encoding: utf-8
class SiteConfigsController < ApplicationController
  # GET /site_configs
  # GET /site_configs.json
  def index
    @site_configs = SiteConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_configs }
    end
  end

  # GET /site_configs/1
  # GET /site_configs/1.json
  def show
    @site_config = SiteConfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site_config }
    end
  end

  # GET /site_configs/new
  # GET /site_configs/new.json
  def new
    @site_config = SiteConfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site_config }
    end
  end

  # GET /site_configs/1/edit
  def edit
    @site_config = SiteConfig.find(params[:id])
  end

  # POST /site_configs
  # POST /site_configs.json
  def create
    @site_config = SiteConfig.new(site_config_params)

    respond_to do |format|
      if @site_config.save
        format.html { redirect_to @site_config, notice: 'Site config was successfully created.' }
        format.json { render json: @site_config, status: :created, location: @site_config }
      else
        format.html { render action: "new" }
        format.json { render json: @site_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_configs/1
  # PATCH/PUT /site_configs/1.json
  def update
    @site_config = SiteConfig.find(params[:id])

    respond_to do |format|
      if @site_config.update_attributes(site_config_params)
        format.html { redirect_to @site_config, notice: 'Site config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_configs/1
  # DELETE /site_configs/1.json
  def destroy
    @site_config = SiteConfig.find(params[:id])
    @site_config.destroy

    respond_to do |format|
      format.html { redirect_to site_configs_url }
      format.json { head :no_content }
    end
  end

  #修改logo
  def logo
    image = params[:logo_url]
    @ret = [true, "修改logo成功", "null"]

    original_name = image.original_filename.to_s
    types   = chk_image_name(original_name.to_s)
    if types.size > 0
	  uid = UUIDTools::UUID.md5_create(UUIDTools::UUID_DNS_NAMESPACE, original_name+Time.now.to_s).to_s
      logo_name  = uid + types[0]

      image_path = Rails.root.join("public","favicon", logo_name)
      File.open(image_path, "wb") { |f| f.write(image.read) }

      @site_config = SiteConfig.find(1)
      @site_config.update_attribute(:text4,logo_name)
	  @ret[2] = logo_name
    else
      @ret = [false, "图片格式不正确", "null"]
    end

  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def site_config_params
      params.require(:site_config).permit(:name, :text1, :text2, :text3, :text4, :text5, :text6, :text7, :text8, :text9)
    end

  def chk_image_name(str)
    types = %w(.jpg .jpeg .png .bmp .gif .ico).select { |d| str.downcase.include?(d) }
  end
end
