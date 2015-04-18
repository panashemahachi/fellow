class ProfilesController < ApplicationController
	    layout "platform"

  def show
  	@user = User.find_by_username(params[:id])

  	if not(current_user)
  		respond_to do |format|
      		format.html {render :layout => 'join'}
    	end


  	elsif @user
  		render action: :show
  	end
  end

  def liked_artifacts
  end
end
