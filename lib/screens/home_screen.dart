import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/widgets/double_icon_button_widget.dart';
import '/core/routes/routes_names.dart';
import '/core/utils/theme_util.dart';
import '/core/themes/colors_palette.dart';
import '/screens/home/home_favorites_widget.dart';
import '/screens/home/home_settings_widget.dart';
import '/screens/home/home_widget.dart';
import 'home/home_cards_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final _pageController = PageController();

  Widget baseLayout({required Widget widget}) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: widget,
        ),
        // BOTON QUE ESTA POR DENTRO DE TODOS LOS WIDGETS HIJOS DE HOME SCREEN
        // Positioned(
        //   top: 4,
        //   right: 8,
        //   child: DoubleIconButtonWidget(
        //     onTap: () => Get.toNamed(nameCreateQrCodeStepOneScreen),
        //   ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('titleHome'.tr),
        actions: <Widget>[
          Visibility(
            visible: _currentPage == 0,
            child: DoubleIconButtonWidget(
              onTap: () => Get.toNamed(nameCreateQrCodeStepOneScreen),
            ),
          ),
          Visibility(
            visible: _currentPage == 1,
            child: DoubleIconButtonWidget(
              iconMain: Icons.person,
              onTap: () => Get.toNamed(nameCreateBusinessCard),
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          baseLayout(widget: const HomeWidget()),
          baseLayout(widget: const HomeCardsWidget()),
          baseLayout(widget: const HomeFavoritesWidget()),
          baseLayout(widget: const HomeSettingsWidget()),
        ],
        onPageChanged: (index) {
          // Use a better state management solution
          // setState is used for simplicity
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? crBackground
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? crBackground.withOpacity(0.4)
                  : Colors.black
                      .withOpacity(0.4), // Sombra visible en modo oscuro
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomBar(
          selectedIndex: _currentPage,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _currentPage = index);
          },
          backgroundColor: Colors.transparent,
          items: <BottomBarItem>[
            BottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: !ThemeUtil.isDarkMode() ? crPrimary : crPrimaryDark,
              inactiveColor:
                  !ThemeUtil.isDarkMode() ? crSecondary : crSecondaryDark,
            ),
            BottomBarItem(
              icon: const Icon(Icons.contact_emergency),
              title: Text('tabCards'.tr),
              activeColor: !ThemeUtil.isDarkMode() ? crPrimary : crPrimaryDark,
              inactiveColor:
                  !ThemeUtil.isDarkMode() ? crSecondary : crSecondaryDark,
            ),
            BottomBarItem(
              icon: const Icon(Icons.favorite),
              title: Text('tabFavorites'.tr),
              activeColor: Colors.red,
              inactiveColor:
                  !ThemeUtil.isDarkMode() ? crSecondary : crSecondaryDark,
            ),
            BottomBarItem(
              icon: const Icon(Icons.settings),
              title: Text('tabSettings'.tr),
              activeColor: !ThemeUtil.isDarkMode() ? crPrimary : crPrimaryDark,
              inactiveColor:
                  !ThemeUtil.isDarkMode() ? crSecondary : crSecondaryDark,
            ),
          ],
        ),
      ),
    );
  }
}
