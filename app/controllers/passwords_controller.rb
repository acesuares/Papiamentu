class PasswordsController < Devise::PasswordsController
  protected
   def after_resetting_password_path_for(resource)
     Devise.sign_in_after_reset_password ? '/?state=password_changed'  : new_session_path(resource_name)
   end

   # The path used after sending reset password instructions
   def after_sending_reset_password_instructions_path_for(resource_name)
     new_session_path(resource_name) if is_navigational_format?
   end

end
