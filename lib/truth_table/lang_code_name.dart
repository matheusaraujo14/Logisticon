import 'dart:io';

enum LanguageCode {
  eng,
  cmn,
  hin,
  spa,
  fra,
  arb,
  ben,
  rus,
  por,
  ind,
  urd,
  deu,
  jpn,
  swh,
  mar,
  tel,
  pnb,
  wuu,
  tam,
  tur,
  kor,
  vie,
  yue,
  jav,
  ita,
  arz,
  hau,
  tha,
  guj,
  kan,
  pes,
  bho,
  hak,
  cjy,
  fil,
  mya,
  pol,
  yor,
  ory,
  mal,
  hsn,
  mai,
  ukr,
  ary,
  pan,
  sun,
  arq,
  apd,
  pcm,
  zul,
  ibo,
  amh,
  uzn,
  snd,
  apc,
  npi,
  ron,
  tgl,
  nld,
  aec,
  gan,
  pbu,
  mag,
  skr,
  xho,
  zlm,
  khm,
  afr,
  sin,
  som,
  hne,
  ceb,
  acm,
  asm,
  tts,
  kmr,
  acw,
  fuv,
  bar,
  azb,
  nso,
  sot,
  ces,
  ell,
  ctg,
  kaz,
  swe,
  dcc,
  hun,
  sck,
  kin,
  wes,
  syl,
  ajp,
  aeb,
  ayn,
}

const List<String> codeMostSpokenLanguages = [
  'eng',
  'cmn',
  'hin',
  'spa',
  'fra',
  'arb',
  'ben',
  'rus',
  'por',
  'ind',
  'urd',
  'deu',
  'jpn',
  'swh',
  'mar',
  'tel',
  'pnb',
  'wuu',
  'tam',
  'tur',
  'kor',
  'vie',
  'yue',
  'jav',
  'ita',
  'arz',
  'hau',
  'tts',
  'guj',
  'kan',
  'pes',
  'bho',
  'hak',
  'cjy',
  'fil',
  'mya',
  'pol',
  'yor',
  'ory',
  'mal',
  'hsn',
  'mai',
  'ukr',
  'ary',
  'pan',
  'arq',
  'apd',
  'pcm',
  'zul',
  'ibo',
  'amh',
  'uzn',
  'snd',
  'apc',
  'npi',
  'ron',
  'tgl',
  'nld',
  'aec',
  'gan',
  'pbu',
  'mag',
  'skr',
  'xho',
  'zlm',
  'khm',
  'afr',
  'sin',
  'som',
  'hne',
  'ceb',
  'acm',
  'asm',
  'tts',
  'kmr',
  'acw',
  'fuv',
  'bar',
  'bam',
  'azb',
  'nso',
  'tn',
  'sot',
  'ces',
  'ell',
  'ctg',
  'kaz',
  'swe',
  'dcc',
  'hun',
  'sck',
  'kin',
  'wes',
  'syl',
  'ajp',
  'aeb',
  'ayn',
];

const List<String> mostSpokenLanguages = [
  'english',
  'mandarin chinese',
  'hindi',
  'spanish',
  'french',
  'standard arabic',
  'bengali',
  'russian',
  'portuguese',
  'indonesian',
  'urdu',
  'german',
  'japanese',
  'swahili',
  'marathi',
  'telugu',
  'western panjabi',
  'wu chinese',
  'tamil',
  'turkish',
  'korean',
  'vietnamese',
  'yue chinese',
  'javanese',
  'italian',
  'egyptian arabic',
  'hausa',
  'northeastern thai',
  'gujarati',
  'kannada',
  'iranian persian',
  'bhojpuri',
  'southern min chinese',
  'hakka chinese',
  'jinyu chinese',
  'filipino',
  'burmese',
  'polish',
  'yoruba',
  'odia',
  'malayalam',
  'xiang chinese',
  'maithili',
  'ukrainian',
  'moroccan arabic',
  'punjabi',
  'sunda',
  'algerian arabic',
  'sudanese arabic',
  'nigerian pidgin',
  'zulu',
  'igbo',
  'amharic',
  'northern uzbek',
  'sindhi',
  'north levantine arabic',
  'nepali',
  'romanian',
  'tagalog',
  'dutch',
  'saidi arabic',
  'gan chinese',
  'northern pashto',
  'magahi',
  'saraiki',
  'xhosa',
  'malay',
  'khmer',
  'afrikaans',
  'sinhala',
  'somali',
  'chhattisgarhi',
  'cebuano',
  'mesopotamian arabic',
  'assamese',
  'northeastern thai',
  'northern kurdish',
  'hijazi arabic',
  'nigerian fulfulde',
  'bavarian',
  'bamanankan',
  'south azerbaijani',
  'northern sotho',
  'setswana',
  'southern sotho',
  'czech',
  'greek',
  'chittagonian',
  'kazakh',
  'swedish',
  'deccan',
  'hungarian',
  'jula',
  'sadri',
  'kinyarwanda',
  'cameroonian pidgin',
  'sylheti',
  'south levantine arabic',
  'tunisian arabic',
  'sanaani arabic',
];

var _twoCharCodeToLanguageNameMap = <String, String>{
  'ab': 'abkhazian',
  'aa': 'afar',
  'af': 'afrikaans',
  'sq': 'albanian',
  'am': 'amharic',
  'ar': 'arabic',
  'hy': 'armenian',
  'as': 'assamese',
  'ay': 'aymara',
  'az': 'azerbaijani',
  'ba': 'bashkir',
  'eu': 'basque',
  'bn': 'bengali',
  'dz': 'bhutani',
  'bh': 'bihari',
  'bi': 'bislama',
  'br': 'breton',
  'bg': 'bulgarian',
  'my': 'burmese',
  'be': 'byelorussian',
  'km': 'cambodian',
  'ca': 'catalan',
  'zh': 'chinese',
  'co': 'corsican',
  'hr': 'croatian',
  'cs': 'czech',
  'da': 'danish',
  'nl': 'dutch',
  'en': 'english',
  'eo': 'esperanto',
  'et': 'estonian',
  'fo': 'faeroese',
  'fj': 'fiji',
  'fi': 'finnish',
  'fr': 'french',
  'fy': 'frisian',
  'gd': 'gaelic',
  'gl': 'galician',
  'ka': 'georgian',
  'de': 'german',
  'el': 'greek',
  'kl': 'greenlandic',
  'gn': 'guarani',
  'gu': 'gujarati',
  'ha': 'hausa',
  'iw': 'hebrew',
  'hi': 'hindi',
  'hu': 'hungarian',
  'is': 'icelandic',
  'in': 'indonesian',
  'ia': 'interlingua',
  'ie': 'interlingue',
  'ik': 'inupiak',
  'ga': 'irish',
  'it': 'italian',
  'jp': 'japanese',
  'jw': 'javanese',
  'kn': 'kannada',
  'ks': 'kashmiri',
  'kk': 'kazakh',
  'rw': 'kinyarwanda',
  'ky': 'kirghiz',
  'rn': 'kirundi',
  'ko': 'korean',
  'ku': 'kurdish',
  'lo': 'laothian',
  'la': 'latin',
  'lv': 'latvian',
  'ln': 'lingala',
  'lt': 'lithuanian',
  'mk': 'macedonian',
  'mg': 'malagasy',
  'ms': 'malay',
  'ml': 'malayalam',
  'mt': 'maltese',
  'mi': 'maori',
  'mr': 'marathi',
  'mo': 'moldavian',
  'mn': 'mongolian',
  'na': 'nauru',
  'ne': 'nepali',
  'no': 'norwegian',
  'oc': 'occitan',
  'or': 'oriya',
  'om': 'oromo',
  'ps': 'pashto',
  'fa': 'persian',
  'pl': 'polish',
  'pt': 'portuguese',
  'pa': 'punjabi',
  'qu': 'quechua',
  'rm': 'rhaeto-romance',
  'ro': 'romanian',
  'ru': 'russian',
  'sm': 'samoan',
  'sg': 'sangro',
  'sa': 'sanskrit',
  'sr': 'serbian',
  'sh': 'serbo-croatian',
  'st': 'sesotho',
  'tn': 'setswana',
  'sn': 'shona',
  'sd': 'sindhi',
  'si': 'singhalese',
  'ss': 'siswati',
  'sk': 'slovak',
  'sl': 'slovenian',
  'so': 'somali',
  'es': 'spanish',
  'su': 'sudanese',
  'sw': 'swahili',
  'sv': 'swedish',
  'tl': 'tagalog',
  'tg': 'tajik',
  'ta': 'tamil',
  'tt': 'tatar',
  'te': 'tegulu',
  'th': 'thai',
  'bo': 'tibetan',
  'ti': 'tigrinya',
  'to': 'tonga',
  'ts': 'tsonga',
  'tr': 'turkish',
  'tk': 'turkmen',
  'tw': 'twi',
  'uk': 'ukrainian',
  'ur': 'urdu',
  'uz': 'uzbek',
  'vi': 'vietnamese',
  'vo': 'volapuk',
  'cy': 'welsh',
  'wo': 'wolof',
  'xh': 'xhosa',
  'ji': 'yiddish',
  'yo': 'yoruba',
  'zu': 'zulu',
};

/// Save the two char code to language name map to a file
void saveTwoCodeToLangMap() {
  var f = File(r'c:\dropbox\twocode.txt');
  String s = '';
  s += 'var twoCharCodeToLanguageNameMap = <String, String>{\n';
  for (var lang in _languageNameToTwoCharCodeMap.keys) {
    //
    s +=
        '\'${_languageNameToTwoCharCodeMap[lang]!.toLowerCase()}\': \'${lang.toLowerCase()}\',\n';
  }
  s += '};\n';
  // s += 'var langToCodeMap = <String, String>{\n';
  // for (var lang in langToCodeMap.keys) {
  //   s +=
  //       '\'${langToCodeMap[lang]!.toLowerCase()}\': \'${lang.toLowerCase()}\': ,\n';
  // }
  s += '};\n';
  f.writeAsStringSync(s);
}

var _languageNameToTwoCharCodeMap = <String, String>{
  'abkhazian': 'ab',
  'afar': 'aa',
  'afrikaans': 'af',
  'albanian': 'sq',
  'amharic': 'am',
  'arabic': 'ar',
  'armenian': 'hy',
  'assamese': 'as',
  'aymara': 'ay',
  'azerbaijani': 'az',
  'bashkir': 'ba',
  'basque': 'eu',
  'bengali': 'bn',
  'bangla': 'bn',
  'bhutani': 'dz',
  'bihari': 'bh',
  'bislama': 'bi',
  'breton': 'br',
  'bulgarian': 'bg',
  'burmese': 'my',
  'byelorussian': 'be',
  'cambodian': 'km',
  'catalan': 'ca',
  'chinese': 'zh',
  'corsican': 'co',
  'croatian': 'hr',
  'czech': 'cs',
  'danish': 'da',
  'dutch': 'nl',
  'english': 'en',
  'esperanto': 'eo',
  'estonian': 'et',
  'faeroese': 'fo',
  'fiji': 'fj',
  'finnish': 'fi',
  'french': 'fr',
  'frisian': 'fy',
  'gaelic': 'gd',
  'scots': 'gd',
  'galician': 'gl',
  'georgian': 'ka',
  'german': 'de',
  'greek': 'el',
  'greenlandic': 'kl',
  'guarani': 'gn',
  'gujarati': 'gu',
  'hausa': 'ha',
  'hebrew': 'iw',
  'hindi': 'hi',
  'hungarian': 'hu',
  'icelandic': 'is',
  'indonesian': 'in',
  'interlingua': 'ia',
  'interlingue': 'ie',
  'inupiak': 'ik',
  'irish': 'ga',
  'italian': 'it',
  'japanese': 'jp',
  'javanese': 'jw',
  'kannada': 'kn',
  'kashmiri': 'ks',
  'kazakh': 'kk',
  'kinyarwanda': 'rw',
  'kirghiz': 'ky',
  'kirundi': 'rn',
  'korean': 'ko',
  'kurdish': 'ku',
  'laothian': 'lo',
  'latin': 'la',
  'latvian': 'lv',
  'lettish': 'lv',
  'lingala': 'ln',
  'lithuanian': 'lt',
  'macedonian': 'mk',
  'malagasy': 'mg',
  'malay': 'ms',
  'malayalam': 'ml',
  'maltese': 'mt',
  'maori': 'mi',
  'marathi': 'mr',
  'moldavian': 'mo',
  'mongolian': 'mn',
  'nauru': 'na',
  'nepali': 'ne',
  'norwegian': 'no',
  'occitan': 'oc',
  'oriya': 'or',
  'oromo': 'om',
  'pashto': 'ps',
  'pushto': 'ps',
  'persian': 'fa',
  'polish': 'pl',
  'portuguese': 'pt',
  'punjabi': 'pa',
  'quechua': 'qu',
  'rhaeto-romance': 'rm',
  'romanian': 'ro',
  'russian': 'ru',
  'samoan': 'sm',
  'sangro': 'sg',
  'sanskrit': 'sa',
  'serbian': 'sr',
  'serbo-croatian': 'sh',
  'sesotho': 'st',
  'setswana': 'tn',
  'shona': 'sn',
  'sindhi': 'sd',
  'singhalese': 'si',
  'siswati': 'ss',
  'slovak': 'sk',
  'slovenian': 'sl',
  'somali': 'so',
  'spanish': 'es',
  'sudanese': 'su',
  'swahili': 'sw',
  'swedish': 'sv',
  'tagalog': 'tl',
  'tajik': 'tg',
  'tamil': 'ta',
  'tatar': 'tt',
  'tegulu': 'te',
  'thai': 'th',
  'tibetan': 'bo',
  'tigrinya': 'ti',
  'tonga': 'to',
  'tsonga': 'ts',
  'turkish': 'tr',
  'turkmen': 'tk',
  'twi': 'tw',
  'ukrainian': 'uk',
  'urdu': 'ur',
  'uzbek': 'uz',
  'vietnamese': 'vi',
  'volapuk': 'vo',
  'welsh': 'cy',
  'wolof': 'wo',
  'xhosa': 'xh',
  'yiddish': 'ji',
  'yoruba': 'yo',
  'zulu': 'zu',
};

const codeToLangMap = <String, String>{
  'eng': 'english',
  'cmn': 'mandarin chinese',
  'hin': 'hindi',
  'spa': 'spanish',
  'fra': 'french',
  'arb': 'standard arabic',
  'ara': 'Arabic',
  'ben': 'bengali',
  'rus': 'russian',
  'por': 'portuguese',
  'ind': 'indonesian',
  'urd': 'urdu',
  'deu': 'german',
  'jpn': 'japanese',
  'swh': 'swahili',
  'mar': 'marathi',
  'tel': 'telugu',
  'pnb': 'western panjabi',
  'wuu': 'wu chinese',
  'tam': 'tamil',
  'tur': 'turkish',
  'kor': 'korean',
  'vie': 'vietnamese',
  'yue': 'yue chinese',
  'jav': 'javanese',
  'ita': 'italian',
  'arz': 'egyptian arabic',
  'hau': 'hausa',
  'tha': 'thai',
  'guj': 'gujarati',
  'kan': 'kannada',
  'pes': 'iranian persian',
  'bho': 'bhojpuri',
  'hak': 'hakka chinese',
  'cjy': 'jinyu chinese',
  'fil': 'filipino',
  'mya': 'burmese',
  'pol': 'polish',
  'yor': 'yoruba',
  'ory': 'odia',
  'mal': 'malayalam',
  'hsn': 'xiang chinese',
  'mai': 'maithili',
  'ukr': 'ukrainian',
  'ary': 'moroccan arabic',
  'pan': 'punjabi',
  'sun': 'sundanese',
  'arq': 'algerian arabic',
  'apd': 'sudanese arabic',
  'pcm': 'nigerian pidgin',
  'zul': 'zulu',
  'ibo': 'igbo',
  'amh': 'amharic',
  'uzn': 'northern uzbek',
  'snd': 'sindhi',
  'apc': 'north levantine arabic',
  'npi': 'nepali',
  'ron': 'romanian',
  'tgl': 'tagalog',
  'nld': 'dutch',
  'aec': 'saidi arabic',
  'gan': 'gan chinese',
  'pbu': 'northern pashto',
  'mag': 'magahi',
  'skr': 'saraiki',
  'xho': 'xhosa',
  'zlm': 'malay',
  'khm': 'khmer',
  'afr': 'afrikaans',
  'sin': 'sinhala',
  'som': 'somali',
  'hne': 'chhattisgarhi',
  'ceb': 'cebuano',
  'acm': 'mesopotamian arabic',
  'asm': 'assamese',
  'tts': 'northeastern thai',
  'kmr': 'northern kurdish',
  'acw': 'hijazi arabic',
  'fuv': 'nigerian fulfulde',
  'bar': 'bavarian',
  'azb': 'south azerbaijani',
  'nso': 'northern sotho',
  'sot': 'southern sotho',
  'ces': 'czech',
  'ell': 'modern greek',
  'ctg': 'chittagonian',
  'kaz': 'kazakh',
  'swe': 'swedish',
  'dcc': 'deccan',
  'hun': 'hungarian',
  'sck': 'sadri',
  'kin': 'kinyarwanda',
  'wes': 'cameroon pidgin',
  'syl': 'sylheti',
  'ajp': 'south levantine arabic',
  'aeb': 'tunisian arabic',
  'ayn': 'sanaani arabic',
  // out of order
  'nan': 'min nan chinese',
  'bam': 'Bambara',
  'tsn': 'Tswana',
};

const langToCodeMap = <String, String>{
  'english': 'eng',
  'mandarin chinese': 'cmn',
  'hindi': 'hin',
  'spanish': 'spa',
  'french': 'fra',
  'standard arabic': 'arb',
  'arabic': 'ara',
  'bengali': 'ben',
  'russian': 'rus',
  'portuguese': 'por',
  'indonesian': 'ind',
  'urdu': 'urd',
  'german': 'deu',
  'japanese': 'jpn',
  'swahili': 'swh',
  'marathi': 'mar',
  'telugu': 'tel',
  'western panjabi': 'pnb',
  'wu chinese': 'wuu',
  'tamil': 'tam',
  'turkish': 'tur',
  'korean': 'kor',
  'vietnamese': 'vie',
  'yue chinese': 'yue',
  'javanese': 'jav',
  'italian': 'ita',
  'egyptian arabic': 'arz',
  'hausa': 'hau',
  'thai': 'tha',
  'gujarati': 'guj',
  'kannada': 'kan',
  'iranian persian': 'pes',
  'bhojpuri': 'bho',
  'hakka chinese': 'hak',
  'jinyu chinese': 'cjy',
  'filipino': 'fil',
  'burmese': 'mya',
  'polish': 'pol',
  'yoruba': 'yor',
  'odia': 'ory',
  'malayalam': 'mal',
  'xiang chinese': 'hsn',
  'maithili': 'mai',
  'ukrainian': 'ukr',
  'moroccan arabic': 'ary',
  'punjabi': 'pan',
  'sundanese': 'sun',
  'algerian arabic': 'arq',
  'sudanese arabic': 'apd',
  'nigerian pidgin': 'pcm',
  'zulu': 'zul',
  'igbo': 'ibo',
  'amharic': 'amh',
  'northern uzbek': 'uzn',
  'sindhi': 'snd',
  'north levantine arabic': 'apc',
  'nepali': 'npi',
  'romanian': 'ron',
  'tagalog': 'tgl',
  'dutch': 'nld',
  'saidi arabic': 'aec',
  'gan chinese': 'gan',
  'northern pashto': 'pbu',
  'magahi': 'mag',
  'saraiki': 'skr',
  'xhosa': 'xho',
  'malay': 'zlm',
  'khmer': 'khm',
  'afrikaans': 'afr',
  'sinhala': 'sin',
  'somali': 'som',
  'chhattisgarhi': 'hne',
  'cebuano': 'ceb',
  'mesopotamian arabic': 'acm',
  'assamese': 'asm',
  'northeastern thai': 'tts',
  'northern kurdish': 'kmr',
  'hijazi arabic': 'acw',
  'nigerian fulfulde': 'fuv',
  'bavarian': 'bar',
  'south azerbaijani': 'azb',
  'northern sotho': 'nso',
  'southern sotho': 'sot',
  'czech': 'ces',
  'modern greek': 'ell',
  'chittagonian': 'ctg',
  'kazakh': 'kaz',
  'swedish': 'swe',
  'deccan': 'dcc',
  'hungarian': 'hun',
  'sadri': 'sck',
  'kinyarwanda': 'kin',
  'cameroon pidgin': 'wes',
  'sylheti': 'syl',
  'south levantine arabic': 'ajp',
  'tunisian arabic': 'aeb',
  'sanaani arabic': 'ayn',
  // out of order
  'min nan chinese': 'nan',
  'bambara': 'bam',
  'Tswana': 'tsn',
};

/// code is the code of a language such as 'eng' or 'de'. Return a language name.
String? codeToLanguageName(String code) {
  int size = code.length;

  code = code.toLowerCase();
  if (size == 3) {
    return codeToLangMap[code];
  } else {
    return _twoCharCodeToLanguageNameMap[code];
  }
}

String standardizeLanguageName(String languageName) {
  // if (languageName.contains('panj')) {
  //   int size = languageName.length;
  //   for (int i = 0; i < size; ++i) {
  //     if (languageName[i] != 'western panjabi'[i]) {
  //       print('different in $i, ${languageName[i]} != ${'western panjabi'[i]}');
  //       break;
  //     }
  //   }
  // }
  switch (languageName) {
    case 'mandarin':
    case 'chinese':
      return 'mandarin chinese';

    case 'arabic':
      return 'standard arabic';

    case 'persian': // Iran
      return 'iranian persian';

    case 'pashto':
      return 'northern pashto';

    case 'camerron':
    case 'cameroonian':
    case 'cameroonian pidgin':
      return 'cameroon pidgin';

    case 'greek':
      return 'modern greek';

    case 'azerbaijani':
      return 'south azerbaijani';

    case 'thai':
      return 'northeastern thai';

    case 'kurdish':
      return 'northern kurdish';

    case 'saidi':
      return 'saidi arabic';

    case 'gan':
      return 'gan chinese';

    case 'uzbek':
      return 'northern uzbek';

    case 'algerian':
      return 'algerian arabic';

    case 'sudanese':
      return 'sudanese arabic';

    case 'moroccan':
      return 'moroccan arabic';

    case 'xiang':
      return 'xiang chinese';

    case 'hakka':
      return 'hakka chinese';

    case 'jinyu':
      return 'jinyu chinese';

    case 'wu':
      return 'wu chinese';

    case 'min nan chinese':
      return 'southern min chinese';

    case 'sundanese':
      return 'sunda';

    case 'hijazi':
      return 'hijazi arabic';

    case 'bamanankan':
      return 'bambara';

    case 'jula':
      return 'dyu';
  }
  return languageName;
}

String? languageNameToCode(String languageName) {
  languageName = standardizeLanguageName(languageName.toLowerCase());

  String? code = langToCodeMap[languageName];
  if (code != null) {
    return code;
  } else {
    return _languageNameToTwoCharCodeMap[languageName];
  }
}

bool isLanguageSupportedByInventiMundi(String languageName) {
  languageName = languageName.toLowerCase();
  return languageName == 'eng' || languageName == 'english';
}

/// list of languages supported by the app
List<String> languagesOfApp = [
  'english',
  'mandarin chinese',
  'hindi',
  'spanish',
  'french',
  'standard arabic',
  'bengali',
  'russian',
  'portuguese',
  'indonesian',
  'urdu', // Pakistan
  'german',
  'japanese',
  'swahili', // Africa
  'marathi', // India
  'telugu', // India
  'western panjabi', // India and Pakistan
  'wu chinese',
  'tamil',
  'turkish',
  'korean',
  'vietnamese',
  'yue chinese',
  'javanese',
  'italian',
  // others
  'southern min chinese',
  'hakka chinese',
  'jinyu chinese',
  'polish',
  'ukrainian',
  'nigerian pidgin',
  'romanian',
  'dutch',
  'czech',
  'greek',
  'swedish',
];

/// map of languages initially supported by the app
const initiallySupportedLanguagesApp = {
  'english': 'eng',
  'mandarin chinese': 'cmn',
  'german': 'deu',
  'japanese': 'jpn',
  'hindi': 'hin',
  'spanish': 'spa',
  'french': 'fra',
  'portuguese': 'por',
  'standard arabic': 'arb',
  'russian': 'rus',
  'indonesian': 'ind',
  'italian': 'ita',
  'korean': 'kor',
  'turkish': 'tur',
  'polish': 'pol',
  'bengali': 'ben',
  'urdu': 'urd',
  'western panjabi': 'pnb',
  'wu chinese': 'wuu',
  'tamil': 'tam',
  'vietnamese': 'vie',
  'yue chinese': 'yue',
  'javanese': 'jav',
  'malayalam': 'mal',
  'filipino': 'fil',
};

/// list of languages supported by the app
const initiallySupportedLanguagesAppList = [
  'english',
  'mandarin chinese',
  'german',
  'japanese',
  'hindi',
  'spanish',
  'french',
  'portuguese',
  'standard arabic',
  'russian',
  'indonesian',
  'italian',
  'korean',
  'turkish',
  'polish',
  'bengali',
  'urdu',
  'western panjabi',
  'wu chinese',
  'tamil',
  'vietnamese',
  'yue chinese',
  'javanese',
  'malayalam',
  'filipino',
];

List<(String languageName, String langCode)>
    get initiallySupportedByAppTupleOfLanguageNameLangCodeList {
  List<(String languageName, String langCode)> retList = [];
  for (var langName in initiallySupportedLanguagesAppList) {
    var langCode = langToCodeMap[langName];
    if (langCode == null) {
      throw 'In initiallySupportedLanguageLangCodeAppList, langCode is null for $langName';
    }
    retList.add((langName, langCode));
  }
  return retList;
}

String? threeToTwoLetterCode(String threeLetterCode) {
  // Converte o código de três letras para minúsculas
  threeLetterCode = threeLetterCode.toLowerCase();

  // Encontra o nome da língua correspondente ao código de três letras
  String? languageName = codeToLangMap[threeLetterCode];

  if (languageName != null) {
    // Encontra o código de duas letras correspondente ao nome da língua
    print(_twoCharCodeToLanguageNameMap.entries.firstWhere(
        (entry) => entry.value == languageName,
        orElse: () => const MapEntry('', '')));
    return _twoCharCodeToLanguageNameMap.entries
        .firstWhere((entry) => entry.value == languageName,
            orElse: () => const MapEntry('', ''))
        .key;
  }

  // Retorna null se o código de três letras não for encontrado
  return null;
}

String? threeLetterCodeToCountryCode(String threeLetterCode) {
  String? languageName = codeToLangMap[threeLetterCode];
  switch (languageName) {
    case 'standard arabic':
      return 'SA';
    case 'english':
      return 'US';
    case 'spanish':
      return 'ES';
    case 'french':
      return 'FR';
    case 'portuguese':
      return 'BR';
    case 'russian':
      return 'RU';
    case 'german':
      return 'DE';
    case 'japanese':
      return 'JP';
    case 'italian':
      return 'IT';
    case 'korean':
      return 'KR';
    case 'mandarin chinese':
      return 'CN';
    case 'hindi':
      return 'IN';
    case 'arabic':
      return 'SA';
    case 'indonesian':
      return 'ID';
    case 'turkish':
      return 'TR';
  }
}
