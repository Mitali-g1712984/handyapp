import 'package:get/get.dart';
import 'package:handy/language/arabic_language.dart';
import 'package:handy/language/bengali_language.dart';
import 'package:handy/language/chinese_language.dart';
import 'package:handy/language/english_language.dart';
import 'package:handy/language/french_language.dart';
import 'package:handy/language/german_language.dart';
import 'package:handy/language/hindi_language.dart';
import 'package:handy/language/indonesian_language.dart';
import 'package:handy/language/italian_language.dart';
import 'package:handy/language/korean_language.dart';
import 'package:handy/language/portuguese_language.dart';
import 'package:handy/language/russian_language.dart';
import 'package:handy/language/spanish_language.dart';
import 'package:handy/language/swahili_language.dart';
import 'package:handy/language/tamil_language.dart';
import 'package:handy/language/telugu_language.dart';
import 'package:handy/language/turkish_language.dart';
import 'package:handy/language/urdu_language.dart';

class AppLanguages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar_DZ": arDZ,
        "bn_In": bnIN,
        "zh_CN": zhCN,
        "en_US": enUS,
        "fr_Fr": frCH,
        "de_De": deAT,
        "hi_IN": hiIN,
        "it_In": itIT,
        "id_ID": idID,
        "ko_KR": koKR,
        "pt_PT": ptPT,
        "ru_RU": ruRU,
        "es_ES": esES,
        "sw_KE": swKE,
        "tr_TR": trTR,
        "te_IN": teIN,
        "ta_IN": taIN,
        "ur_PK": urPK,
      };
}

final List<LanguageModel> languages = [
  LanguageModel("dz", "Arabic", 'ar', 'DZ'),
  LanguageModel("🇮🇳", "Bengali", 'bn', 'IN'),
  LanguageModel("🇨🇳", "Chinese", 'zh', 'CN'),
  LanguageModel("🇺🇸", "English", 'en', 'US'),
  LanguageModel("🇫🇷", "French", 'fr', 'FR'),
  LanguageModel("🇩🇪", "German", 'de', 'DE'),
  LanguageModel("🇮🇳", "Hindi", 'hi', 'IN'),
  LanguageModel("🇮🇹", "Italian", 'it', 'IT'),
  LanguageModel("🇮🇩", "Indonesian", 'id', 'ID'),
  LanguageModel("🇰🇵", "Korean", 'ko', 'KR'),
  LanguageModel("🇵🇹", "Portuguese", 'pt', 'PT'),
  LanguageModel("🇷🇺", "Russian", 'ru', 'RU'),
  LanguageModel("🇪🇸", "Spanish", 'es', 'ES'),
  LanguageModel("🇰🇪", "Swahili", 'sw', 'KE'),
  LanguageModel("🇹🇷", "Turkish", 'tr', 'TR'),
  LanguageModel("🇮🇳", "Telugu", 'te', 'IN'),
  LanguageModel("🇮🇳", "Tamil", 'ta', 'IN'),
  LanguageModel("🇵🇰", "Urdu", 'ur', 'PK'),
];

class LanguageModel {
  LanguageModel(
    this.symbol,
    this.language,
    this.languageCode,
    this.countryCode,
  );

  String language;
  String symbol;
  String countryCode;
  String languageCode;
}
