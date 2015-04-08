class ArtifactsController < ApplicationController
  before_action :set_artifact, only: [:show, :edit, :update, :destroy]

  # GET /artifacts
  # GET /artifacts.json
  def index
    if params[:tag]
      @articles = Artifact.tagged_with(params[:tag])
    else
      @artifacts = Artifact.where(user_id: current_user.id).order(id: :desc)
    end
  end

  # GET /artifacts/1
  # GET /artifacts/1.json
  def show
  end

  # GET /artifacts/new
  def new
    #@artifact = Artifact.new
    @artifact = current_user.artifacts.build
  end

  # GET /artifacts/1/edit
  def edit
  end

  # POST /artifacts
  # POST /artifacts.json
  def create
    #@artifact = Artifact.new(artifact_params)
    if current_user
      @artifact = current_user.artifacts.build(artifact_params)
      if @artifact.link != ""

      # @artifact.content = Nokogiri::HTML::Document.parse(HTTParty.get(URI.encode(@artifact.link.to_s))).body
      @artifact.content =  Nokogiri::HTML(HTTParty.get("http://www.businessinsider.com/google-exec-sridhar-ramaswamy-controls-a-60-billion-business-2015-4").body.to_s).at_css("body").css('h1, h2, h3, h4, h5, h6').sort()
      end
    else
      @artifact = Artifact.new(artifact_params)
    end

    respond_to do |format|
      if @artifact.save
        format.html { redirect_to @artifact, notice: 'Artifact was successfully created.' }
        format.json { render :show, status: :created, location: @artifact }
      else
        format.html { render :new }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artifacts/1
  # PATCH/PUT /artifacts/1.json
  def update
    respond_to do |format|
      if @artifact.update(artifact_params)
        format.html { redirect_to @artifact, notice: 'Artifact was successfully updated.' }
        format.json { render :show, status: :ok, location: @artifact }
      else
        format.html { render :edit }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artifacts/1
  # DELETE /artifacts/1.json
  def destroy
    @artifact.destroy
    respond_to do |format|
      format.html { redirect_to artifacts_url, notice: 'Artifact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artifact
      @artifact = Artifact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artifact_params
      params.require(:artifact).permit(:title, :kind, :content, :user_id, :tag_list)
    end
end
