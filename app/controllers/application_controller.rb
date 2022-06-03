class ApplicationController < InlineFormsApplicationController
  protect_from_forgery
  check_authorization :unless => :devise_controller?
  before_action :set_locale
  before_action :set_paper_trail_whodunnit
  after_action :track_action

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  I18n.available_locales = AVAILABLE_LOCALES
  I18n.default_locale = DEFAULT_LOCALE

  private
  def set_locale
    I18n.locale = LOCALES_OPTIONS[current_user.locale] if current_user
  end

  protected
  def track_action
    ahoy.track "#{controller_name}:#{action_name}", request.path_parameters
  end
end
