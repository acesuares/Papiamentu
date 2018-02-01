MODEL_TABS = %w(words clients sources wordtypes goals users roles glossaries)
HIDDEN_MODELS = %w()

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
