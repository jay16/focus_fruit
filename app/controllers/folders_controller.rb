class FoldersController < ApplicationController
  # GET /folders
  # GET /folders.json
  def index
    @folders = Folder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
    end
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @folder = Folder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @folder }
    end
  end

  # GET /folders/new
  # GET /folders/new.json
  def new
    @folder = Folder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @folder }
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = Folder.find(params[:id])
  end

  # POST /folders/1/upload
  # 上传图片
  def upload
    @folder = Folder.find(params[:id])
    deal_with_local(@folder)
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
        format.json { render json: @folder, status: :created, location: @folder }
      else
        format.html { render action: "new" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    @folder = Folder.find(params[:id])

    respond_to do |format|
      if @folder.update_attributes(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to folders_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def folder_params
      params.require(:folder).permit(:desc, :name)
    end

  def chk_image_name(str)
    types = %w(.jpg .jpeg .png .bmp .gif .ico).select { |d| str.downcase.include?(d) }
    type = (types.empty? ? ".jpg" : types[0])

    name = UUIDTools::UUID.md5_create(UUIDTools::UUID_DNS_NAMESPACE, str+Time.now.to_s).to_s
    return (name+type)
  end

  def deal_with_local(folder)
    (0..50).each_with_index do |i,index|
      key = "file_#{i}"
      next if params[key].nil?

      image = params[key]

      original_name = image.original_filename.to_s
      image_name   = chk_image_name(original_name)
      image_path = Rails.root.join("public","pictures",folder.id.to_s)

      FileUtils.mkdir_p(image_path) unless File.exist?(image_path)

      image_path = File.join(image_path, image_name)
      File.open(image_path, "wb") { |f| f.write(image.read) }

      picture = folder.pictures.create({
       :name => original_name,
       :desc => original_name,
       :store => image_name
       })
    end
  end
end
