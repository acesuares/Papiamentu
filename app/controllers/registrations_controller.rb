class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected
  def after_sign_up_path_for(resource)
    "/auth/users/sign_in?state=after_sign_up"
  end

  def after_inactive_sign_up_path_for(resource)
    "/auth/users/sign_in?state=after_sign_up"
  end

  def after_update_path_for(resource)
    '/?state=password_changed'
  end

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
   devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
