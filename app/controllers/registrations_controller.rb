class RegistrationsController < Devise::RegistrationsController
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

end
