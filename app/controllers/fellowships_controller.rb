class FellowshipsController < ApplicationController
      layout "platform"

  before_action :set_fellowship, only: [:show, :edit, :update, :destroy]

  # GET /fellowships
  # GET /fellowships.json
  def index
    @fellowships = Fellowship.all
  end

  # GET /fellowships/1
  # GET /fellowships/1.json
  def show
  end

  # GET /fellowships/new
  def new
    @fellowship = Fellowship.new
  end

  # GET /fellowships/1/edit
  def edit
  end

  # POST /fellowships
  # POST /fellowships.json
  def create
    @fellowship = Fellowship.new(fellowship_params)
    @fellowship.users << current_user

    respond_to do |format|
      if @fellowship.save
        format.html { redirect_to @fellowship, notice: 'Fellowship was successfully created.' }
        format.json { render :show, status: :created, location: @fellowship }
      else
        format.html { render :new }
        format.json { render json: @fellowship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fellowships/1
  # PATCH/PUT /fellowships/1.json
  def update
    respond_to do |format|
      if @fellowship.update(fellowship_params)
        format.html { redirect_to @fellowship, notice: 'Fellowship was successfully updated.' }
        format.json { render :show, status: :ok, location: @fellowship }
      else
        format.html { render :edit }
        format.json { render json: @fellowship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fellowships/1
  # DELETE /fellowships/1.json
  def destroy
    @fellowship.destroy
    respond_to do |format|
      format.html { redirect_to fellowships_url, notice: 'Fellowship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def members
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fellowship
      @fellowship = Fellowship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fellowship_params
     params.require(:fellowship).permit(:fellowship_name, :user_id)
    end
end
