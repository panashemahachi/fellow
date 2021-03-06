class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
   protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }
        
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :profile_pic, :description) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :profile_pic, :description, :facebook_link, :twitter_link, :linkedin_link) }
  end

 def update_resource(resource, params)
    resource.update_without_password(params)
  end


def layout_by_resource
  if devise_controller?
      if action_name == 'new' or action_name == 'create' 
      'info'
    else
      'platform'
    end
    elsif artifacts_controller?
      'info'
    end
  end

end
