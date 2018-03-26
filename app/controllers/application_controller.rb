class ApplicationController < InlineFormsApplicationController
  protect_from_forgery

  # Comment next two lines if you don't want Devise authentication
  before_action :authenticate_user!

  # Comment next 6 lines if you want CanCan authorization
  enable_authorization :unless => :devise_controller?

  rescue_from CanCan::Unauthorized do |exception|
    redirect_to root_path, alert: exception.message
  end

  # Uncomment next line if you want I18n (based on subdomain)
  # before_filter :set_locale

  # Uncomment next line and specify available locales
  I18n.available_locales = [ :en, :pap ]

  # Uncomment next line and specify default locale
  I18n.default_locale = :pap

  # Uncomment next nine line if you want locale based on subdomain, like 'it.example.com, de.example.com'
  # def set_locale
  #   I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  # end
  #
  # def extract_locale_from_subdomain
  #   locale = request.subdomains.first
  #   return nil if locale.nil?
  #   I18n.available_locales.include?(locale.to_sym) ? locale.to_s : nil
  # end
end
