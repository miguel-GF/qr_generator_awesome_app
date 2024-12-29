import 'dart:ui';

import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_strings.dart';
import '/core/constants/app_translations_keys/locale_countries_translations_keys.dart';

class LocaleUtil {
  static Locale getLocale(String code) {
    late Locale locale;
    switch (code) {
      case 'en_US':
        locale = const Locale('en', 'US');
        break;
      default:
        locale = const Locale('es', 'MX');
    }
    return locale;
  }

  static void changeLocale(String code) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Locale locale = getLocale(code);
    Get.updateLocale(locale);
    prefs.setString(keyLocale, code);
  }

  static void changeInitialLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? localeCode = prefs.getString(keyLocale);
    if (localeCode != null) {
      final Locale locale = getLocale(localeCode);
      Get.updateLocale(locale);
    } else {
      Get.updateLocale(Get.deviceLocale!);
    }
  }

  static List<SelectedListItem> getCountries() {
    LocaleCountriesTranslationsKeys trKey = LocaleCountriesTranslationsKeys();
    // final List<Map<String, dynamic>> countries = [
    //   {
    //     'name': trKey.nameMexico.tr,
    //     'value': 'es_MX',
    //   },
    //   {
    //     'name': trKey.nameUsa.tr,
    //     'value': 'en_US',
    //   }
    // ];
    final List<SelectedListItem> countries = [
      SelectedListItem(
        name: trKey.nameMexico.tr,
        value: 'es_MX',
      ),
      SelectedListItem(
        name: trKey.nameUsa.tr,
        value: 'en_US',
      ),
    ];
    return countries;
  }

  static List<String> getCountriesNames() {
    LocaleCountriesTranslationsKeys trKey = LocaleCountriesTranslationsKeys();
    final List<String> names = [trKey.nameMexico.tr, trKey.nameUsa.tr];
    return names;
  }
}
