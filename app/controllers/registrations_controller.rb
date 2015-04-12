class RegistrationsController < Devise::RegistrationsController

   def update_resource(resource, params)
    if current_user.provider == "twitter"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_without_password(params)
    end
  end

end