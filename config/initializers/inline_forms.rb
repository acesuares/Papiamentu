MODEL_TABS = %w(words sources wordtypes goals users roles glossaries spelling_groups)
HIDDEN_MODELS = %w()

AVAILABLE_LOCALES = [ "pap-CW", "pap-AW", "en", "nl"  ]
# please make sure you never change the order! FIXME
# for some reason this need to be strings and not symbols
DEFAULT_LOCALE = "pap-CW"
LOCALES_OPTIONS = (1..AVAILABLE_LOCALES.size).zip(AVAILABLE_LOCALES).to_h

YANDEX_LANGUAGES = [:en, :nl, :es, :pt, :de]

VIA_WEBSITE = 14 # this happens to be the source id for papiamentu.info

JA_NEE  =               {
                          1 => 'options.empty',
                          2 => 'options.no',
                          3 => 'options.yes',
                        }

DELIVERY_SCHEDULES  =   {
                          0 => 'options.empty',
                          1 => 'options.never',
                          2 => 'options.immediately',
                          3 => 'options.daily',
                          4 => 'options.weekly',
                          5 => 'options.monthly',
                        }

CHARACTER_REGEX = /[^'a-zA-ZèéàáòóìíüñçÈÉÀÁÒÓÌÍÜÑÇ ]/

SETTINGS_OPTIONS = %w(new_words own_words most_voted)

DELETED  =               {
                          1 => 'options.no',
                          2 => 'options.yes',
                        }
