import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_strings.dart';
import '../themes/app_theme.dart';

class UtilApp {
  static bool isDarkMode() {
    return Get.isDarkMode;
  }

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

  static void changeTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool darkMode = isDarkMode();
    Get.changeTheme(darkMode ? lightTheme : darkTheme);
    prefs.setBool(keyDarkMode, darkMode ? false : true);
  }

  static void changeInitialTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? spDarkMode = prefs.getBool(keyDarkMode);
    if (spDarkMode != null) {
      Get.changeTheme(spDarkMode ? darkTheme : lightTheme);
    }
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
}
