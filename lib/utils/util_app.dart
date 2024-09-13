import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/constants.dart';
import '/themes/app_theme.dart';

class UtilApp {
  static bool isDarkMode() {
    return Get.isDarkMode;
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
}
