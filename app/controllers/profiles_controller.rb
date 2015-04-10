class ProfilesController < ApplicationController
	    layout "platform"

  def show
  	@user = User.find_by_username(params[:id])

  	if @user
  		render action: :show
  	end
  end

  def liked_artifacts
  end
end
