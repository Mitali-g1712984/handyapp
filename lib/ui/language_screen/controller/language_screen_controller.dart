import 'dart:ui';

import 'package:handy/localization/localizations_delegate.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:handy/utils/preference.dart';

class LanguageScreenController extends GetxController {
  int checkedValue = Constant.storage.read<int>('checkedValue') ?? 2;
  LanguageModel? languagesChosenValue;

  String? prefLanguageCode;
  String? prefCountryCode;

  @override
  void onInit() {
    getLanguageData();
    super.onInit();
  }

  getLanguageData() {
    prefLanguageCode = Preference.shared.getString(Preference.selectedLanguage) ?? 'en';
    prefCountryCode = Preference.shared.getString(Preference.selectedCountryCode) ?? 'US';
    languagesChosenValue = languages
        .where((element) => (element.languageCode == prefLanguageCode && element.countryCode == prefCountryCode))
        .toList()[0];
    update([Constant.idChangeLanguage]);
  }

  onLanguageSave() {
    Preference.shared.setString(Preference.selectedLanguage, languagesChosenValue!.languageCode);
    Preference.shared.setString(Preference.selectedCountryCode, languagesChosenValue!.countryCode);
    Get.updateLocale(Locale(languagesChosenValue!.languageCode, languagesChosenValue!.countryCode));
    Get.back();
  }

  onChangeLanguage(LanguageModel value, int index) {
    languagesChosenValue = value;

    checkedValue = index;

    Constant.storage.write('checkedValue', checkedValue);

    update([Constant.idChangeLanguage]);
  }
}
