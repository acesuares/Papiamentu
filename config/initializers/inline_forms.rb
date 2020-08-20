MODEL_TABS = %w(words sources wordtypes goals users roles glossaries spelling_groups memory_games slide_games)
HIDDEN_MODELS = %w()

LICENSE = "license: <a href='https://creativecommons.org/licenses/by-nc-sa/4.0/' target='_blank'>CC BY-NC-SA 4.0</a>"
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

# CHARACTER_REGEX = /[^'a-zA-ZèéàáòóìíüñçÈÉÀÁÒÓÌÍÜÑÇ ]/
CHARACTER_REGEX = /[^'a-záçèéíñòóùúü ]/i #careful this is a negate regex, i.e. it matches NOT one of those characters.

SETTINGS_OPTIONS = %w(new_words own_words most_voted)

DELETED  =               {
                          1 => 'options.no',
                          2 => 'options.yes',
                        }
