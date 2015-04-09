class RelationshipsController < ApplicationController
    layout "platform"

  def follow
    followee = User.find_by_id(params[:id])
    current_user.follow(followee)
    flash[:notice] = "You are now following #{followee.username}."
    redirect_to :back
  end

  def unfollow
	followee = User.find_by_id(params[:id])
    current_user.stop_following(followee)
    flash[:notice] = "You are no longer following #{followee.username}."
    redirect_to :back
  end

end
