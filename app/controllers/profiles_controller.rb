class ProfilesController < ApplicationController
	    layout "platform"

  def show
  	@user = User.find_by_username(params[:id])

  	if @user
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end
end
