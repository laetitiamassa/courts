class RegistrationsController < Devise::RegistrationsController
  
# def create
#     build_resource(sign_up_params)
#     if User.exists?
# 		redirect_to new_password_path(resource_name), notice: "Vous avez reçu une invitation, acceptez cette invitation pour achever la création de votre compte, ou bien entrez votre email pour réinitialiser votre mot de passe."
		
#       # sign_in @user
#       # # self.resource = warden.authenticate!(auth_options)
#       # set_flash_message(:notice, :signed_in) if is_flashing_format?
#       # sign_in(resource_name, resource)
#       # yield resource if block_given?
#       # respond_with resource, :location => after_sign_in_path_for(resource)

#       # # set_flash_message :notice, :"user already exists"
#       # # sign_in(resource_name, resource)
#       # # respond_with resource, :location => after_sign_in_path_for(resource)
#     else

# 	    resource.save
# 	    yield resource if block_given?
# 	    if resource.persisted?
# 	      if resource.active_for_authentication?
# 	        set_flash_message :notice, :signed_up if is_flashing_format?
# 	        sign_up(resource_name, resource)
# 	        respond_with resource, location: after_sign_up_path_for(resource)
# 	      else
# 	        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
# 	        expire_data_after_sign_in!
# 	        respond_with resource, location: after_inactive_sign_up_path_for(resource)
# 	      end
# 	    else
# 	      clean_up_passwords resource
# 	      set_minimum_password_length
# 	      respond_with resource
# 	    end
# 	end
#   end

# def create
#   if user = User.where(email: sign_up_params[:email]).first
#     user.update_attributes(location: sign_up_params[:location])
#     self.resource = user
#   else
#     self.resource = resource_class.new_with_session(sign_up_params || {}, session)
#   end

#   resource.save
#   yield resource if block_given?
#   if resource.persisted?
#     if resource.active_for_authentication?
#       set_flash_message :notice, :signed_up if is_flashing_format?
#       sign_up(resource_name, resource)
#       respond_with resource, location: after_sign_up_path_for(resource)
#     else
#       set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
#       expire_data_after_sign_in!
#       respond_with resource, location: after_inactive_sign_up_path_for(resource)
#     end
#   else
#     clean_up_passwords resource
#     set_minimum_password_length
#     respond_with resource
#   end
# end

def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      redirect_to new_password_path(resource_name), notice: "Vous avez reçu une invitation, acceptez cette invitation pour achever la création de votre compte, ou bien entrez votre email pour réinitialiser votre mot de passe."
    end
  end

  protected

  def after_sign_up_path_for(resource)
    edit_user_path(@user)
  end


  

end
