MODEL_TABS = %w(words sources wordtypes goals users roles glossaries spelling_groups memory_games slide_games recordings pictures licenses)
HIDDEN_MODELS = %w()

MARTA_WOORDTYPES = {
        "art" => "artíkulo",
        "ath" => "athetivo",
        "atv" => "atverbio",
        "kon" => "konhunshon",
        "num" => "numeral",
        "par" => "partíkula",
        "pre" => "preposishon",
        "pro d" => "pronòmber demostrativo",
        "pro i" => "pronòmber interogativo",
        "pro p" => "pronómber personal/posesivo",
        "sus" => "sustantivo",
        "ver" => "verbo",
}


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

# originally from https://gist.github.com/unleashy/9753ecd5e32c47d936559cca96e27d04
#
module XSConverter
  # noinspection RubyStringKeysInHashInspection
  XSAMPA_MAP = {}
  XSAMPA_MAP['en'] = {
    'b_<'    => 'ɓ',
    'd`'     => 'ɖ',
    'd_<'    => 'ɗ',
    'g_<'    => 'ɠ',
    'h\\'    => 'ɦ',
    'j\\'    => 'ʝ',
    'l`'     => 'ɭ',
    'l\\'    => 'ɺ',
    'n`'     => 'ɳ',
    'p\\'    => 'ɸ',
    'r`'     => 'ɽ',
    'r\\'    => 'ɹ',
    'r\\`'   => 'ɻ',
    's`'     => 'ʂ',
    's\\'    => 'ɕ',
    't`'     => 'ʈ',
    'v\\'    => 'ʋ',
    'x\\'    => 'ɧ',
    'z`'     => 'ʐ',
    'z\\'    => 'ʑ',
    'A'      => 'ɑ',
    'B'      => 'β',
    'B\\'    => 'ʙ',
    'C'      => 'ç',
    'D'      => 'ð',
    'E'      => 'ɛ',
    'F'      => 'ɱ',
    'G'      => 'ɣ',
    'G\\'    => 'ɢ',
    'G\\_<'  => 'ʛ',
    'H'      => 'ɥ',
    'H\\'    => 'ʜ',
    'I'      => 'ɪ',
    'I\\'    => 'ᵻ',
    'J'      => 'ɲ',
    'J\\'    => 'ɟ',
    'J\\_<'  => 'ʄ',
    'K'      => 'ɬ',
    'K\\'    => 'ɮ',
    'L'      => 'ʎ',
    'L\\'    => 'ʟ',
    'M'      => 'ɯ',
    'M\\'    => 'ɰ',
    'N'      => 'ŋ',
    'N\\'    => 'ɴ',
    'O'      => 'ɔ',
    'O\\'    => 'ʘ',
    'P'      => 'ʋ',
    'Q'      => 'ɒ',
    'R'      => 'ʁ',
    'R\\'    => 'ʀ',
    'S'      => 'ʃ',
    'T'      => 'θ',
    'U'      => 'ʊ',
    'U\\'    => 'ᵿ',
    'V'      => 'ʌ',
    'W'      => 'ʍ',
    'X'      => 'χ',
    'X\\'    => 'ħ',
    'Y'      => 'ʏ',
    'Z'      => 'ʒ',
    '.'      => '.',
    '"'      => 'ˈ',
    '%'      => 'ˌ',
    "'"      => 'ʲ',
    '_j'     => 'ʲ',
    ':'      => 'ː',
    ':\\'    => 'ˑ',
    '-'      => '',
    '@'      => 'ə',
    '@\\'    => 'ɘ',
    '{'      => 'æ',
    '}'      => 'ʉ',
    '1'      => 'ɨ',
    '2'      => 'ø',
    '3'      => 'ɜ',
    '3\\'    => 'ɞ',
    '4'      => 'ɾ',
    '5'      => 'ɫ',
    '6'      => 'ɐ',
    '7'      => 'ɤ',
    '8'      => 'ɵ',
    '9'      => 'œ',
    '&'      => 'ɶ',
    '?'      => 'ʔ',
    '?\\'    => 'ʕ',
    '<\\'    => 'ʢ',
    '>\\'    => 'ʡ',
    '^'      => 'ꜛ',
    '!'      => 'ꜜ',
    '!\\'    => 'ǃ',
    '|'      => '|',
    '|\\'    => 'ǀ',
    '||'     => '‖',
    '|\\|\\' => 'ǁ',
    '=\\'    => 'ǂ',
    '-\\'    => '‿',
    '_"'     => ' ̈',
    '_+'     => '̟',
    '_-'     => '̠',
    '_/'     => '̌',
    '_0'     => '̥',
    '_<'     => '',
    '='      => '̩',
    '_='     => '̩',
    '_>'     => 'ʼ',
    '_?\\'   => 'ˤ',
    '_\\'    => '̂',
    '_^'     => '̯',
    '_}'     => '̚',
    '`'      => '˞',
    '~'      => '̃',
    '_~'     => '̃',
    '_A'     => '̘',
    '_a'     => '̺',
    '_B'     => '̏',
    '_B_L'   => '᷅',
    '_c'     => '̜',
    '_d'     => '̪',
    '_e'     => '̴',
    '<F>'    => '↘',
    '_F'     => '̂',
    '_G'     => 'ˠ',
    '_H'     => '́',
    '_H_T'   => '᷄',
    '_h'     => 'ʰ',
    '_k'     => '̰',
    '_L'     => '̀',
    '_l'     => 'ˡ',
    '_M'     => '̄',
    '_m'     => '̻',
    '_N'     => '̼',
    '_n'     => 'ⁿ',
    '_O'     => '̹',
    '_o'     => '̞',
    '_q'     => '̙',
    '<R>'    => '↗',
    '_R'     => '̌',
    '_R_F'   => '᷈',
    '_r'     => '̝',
    '_T'     => '̋',
    '_t'     => '̤',
    '_v'     => '̬',
    '_w'     => 'ʷ',
    '_X'     => '̆',
    '_x'     => '̽'
  }.sort_by { |k, v| k.length }.reverse!.to_h.freeze

XSAMPA_MAP['pap_cw'] = {
  'a'    => 'ɐ',
  'e'     => 'ɛ',
  'è'    => 'æ',
  'i'    => 'i',
  'o'    => 'o',
  'ò'    => 'ɒ',
  'u'     => 'u',
  'ù'    => 'ɤ',
  'ü'     => 'y',
  'ai'    => 'aɪ',
  'au'     => 'aʊ',
  'ei'    => 'e',
  'eu'   => 'ɾew',
  'oi'     => 'oːi',
  'òi'    => 'ɔɪ',
  'ou'     => 'ʌu',
  'ui'    => 'wi',
  'ia'    => 'ija',
  'ie'     => 'iæ',
  'iè'    => 'jiæ',
  'io'      => 'ɟiɔ',
  'iu'      => 'ɟu',
  'ua'    => 'wa',
  'ue'      => 'swe',
  'uè'      => 'swɛ',
  'uo'      => 'wɵ',
  'iau'      => 'ɱ',
  'ieu'      => 'ɣ',
  'iou'    => 'ɢ',
  'uai'  => 'ʛ',
  'uei'      => 'ɥ',
}.sort_by { |k, v| k.length }.reverse!.to_h.freeze



  def self.convert(ipa, lang='en')
    xsampa_map_rgx = Regexp.union(XSAMPA_MAP[lang].keys)
    ipa.gsub(xsampa_map_rgx, XSAMPA_MAP[lang])
  end
end
