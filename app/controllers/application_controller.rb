class ApplicationController < InlineFormsApplicationController
  protect_from_forgery
  check_authorization :unless => :devise_controller?

  # rescue_from CanCan::AccessDenied do |exception|
  #   respond_to do |format|
  #     format.json { head :forbidden, content_type: 'text/html' }
  #     format.html { redirect_to main_app.root_url, notice: exception.message }
  #     format.js   { head :forbidden, content_type: 'text/html' }
  #   end
  # end

  I18n.available_locales = [ :en, :nl, "pap-CW" ]
  I18n.default_locale = "pap-CW"

end
