class ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      sign_in(resource) # <= THIS LINE ADDED
      respond_with_navigational(resource){ redirect_to '/?state=confirmed' }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
    end
  end
end
# http://stackoverflow.com/questions/18655334/avoid-sign-in-after-confirmation-link-click-using-devise-gem
