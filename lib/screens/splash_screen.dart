import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/core/routes/routes_names.dart';
import '/core/utils/locale_util.dart';
import '/core/utils/theme_util.dart';
import '/core/constants/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    ThemeUtil.changeInitialTheme();
    LocaleUtil.changeInitialLocale();
    _controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Get.offAndToNamed(nameHomeScreen);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Lottie.asset(
              AppAssets.animationSplash,
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                _controller.forward();
              },
            ),
          ),
        ),
      ),
    );
  }
}
