module I18nHelper
  def translate(key, options={})
    super(key, options.merge(raise: true))
  rescue I18n::MissingTranslationData
    if Rails.env.development?
      key
    else
      key.split('.').last rescue key
    end
  end
  alias :t :translate
end
