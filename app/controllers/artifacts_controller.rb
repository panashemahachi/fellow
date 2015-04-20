class ArtifactsController < ApplicationController

    layout "platform"
  before_action :set_artifact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_owner!, only: [:show]

  # GET /artifacts
  # GET /artifacts.json
  def index
    if params[:search]
      #@artifacts = Artifact.where(user_id: current_user.id).search(params[:search]).order(id: :desc).page(params[:page])

      #@artifacts = Artifact.where(user_id: current_user.id).search(params[:search]).order(created_at: :desc).page(params[:page]).per_page(9)
    
    @artifacts = Artifact.search(params[:search]).records.where(user_id: current_user.id).page(params[:page]).per_page(9)
    #@artifacts = @artifacts.page(params[:page]).per_page(9)

    elsif params[:tag]
      @artifacts = Artifact.tagged_with(params[:tag]).where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per_page(9)
    else
      @artifacts = Artifact.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per_page(9)
      respond_to do |format|
      # get artifacts and paginate on HTML
      format.html
      format.js
      format.json {@artifacts = Artifact.where(user_id: current_user.id).order(created_at: :desc)}
    end
    end
  end

  # GET /artifacts/1
  # GET /artifacts/1.json
  def show
    respond_to do |format|
          format.html {render :layout => 'artifact_view'}
      end
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
    else
      @artifact = Artifact.new(artifact_params)
    end

      if @artifact.link != nil

      # @artifact.content = Nokogiri::HTML::Document.parse(HTTParty.get(URI.encode(@artifact.link.to_s))).body
      #@artifact.content =  Nokogiri::HTML(HTTParty.get("http://www.businessinsider.com/google-exec-sridhar-ramaswamy-controls-a-60-billion-business-2015-4").body.to_s).at_css("body").css('h1, h2, h3, h4, h5, h6').sort()
     source = open(@artifact.link).read

      @artifact.content = Readability::Document.new(source, :tags => %w[div label ol h1 h2 h3 h4 h5 h6 p img a ul li b i a span br em code pre blockquote td tr th table tbody t], :attributes => %w[src href]).content
      object = LinkThumbnailer.generate(@artifact.link)
      @artifact.image = object.images.first.src.to_s
      @artifact.title = object.title
      @artifact.link_favicon = object.favicon
      end

      ### Send email to people in fellowship
      if @artifact.fellowship != nil

        ###### GBTTT: Hacky fix to get id of artifact since it doesn't seem to be set by this time
        projected_id = Artifact.last.id + 1
        FellowshipAddition.added_to_fellowship(Fellowship.where(id: @artifact.fellowship.id).first.users, 
          @artifact, Fellowship.where(id: @artifact.fellowship.id).first.fellowship_name, current_user.id, projected_id).deliver
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

        # Changed to redirect back
        #format.html { redirect_to @artifact, notice: 'Artifact was successfully updated.' }
        format.html { redirect_to :back, notice: 'Artifact was successfully updated.' }
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

  def like
    @artifact = Artifact.find(params[:id])
    @artifact.upvote_by current_user
    redirect_to :back
  end

  def unlike
    @artifact = Artifact.find(params[:id])
    @artifact.downvote_by current_user
    redirect_to :back
  end

  def liked_artifacts
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artifact
      @artifact = Artifact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artifact_params
      params.require(:artifact).permit(:title, :kind, :content, :user_id, :tag_list, :link, :image, :tldr, :fellowship_id, :link_favicon)
    end

    def authenticate_owner!

      # Check to see if the person is the owner.  If not proceed
      if current_user.id != @artifact.user_id

        # If the person with the link isn't part of a fellowship with the article, then they don't have access
        if not current_user.fellowships.include?(@artifact.fellowship)
          raise ActionController::RoutingError.new('Not Found')
        end
      end
    end
end
