import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/utils/util_app.dart';
import '/themes/colors_palette.dart';
import '/screens/home/home_favorites_widget.dart';
import '/screens/home/home_settings_widget.dart';
import '/screens/home/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          HomeWidget(),
          HomeFavoritesWidget(),
          HomeSettingsWidget(),
        ],
        onPageChanged: (index) {
          // Use a better state management solution
          // setState is used for simplicity
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: UtilApp.isDarkMode() ? crPrimary : crPrimaryDark,
            inactiveColor: UtilApp.isDarkMode() ? crSecondary : crSecondaryDark,
          ),
          BottomBarItem(
            icon: const Icon(Icons.favorite),
            title: Text('tabFavorites'.tr),
            activeColor: Colors.red,
            inactiveColor: UtilApp.isDarkMode() ? crSecondary : crSecondaryDark,
          ),
          BottomBarItem(
            icon: const Icon(Icons.settings),
            title: Text('tabSettings'.tr),
            activeColor: UtilApp.isDarkMode() ? crPrimary : crPrimaryDark,
            inactiveColor: UtilApp.isDarkMode() ? crSecondary : crSecondaryDark,
          ),
        ],
      ),
    );
  }
}
