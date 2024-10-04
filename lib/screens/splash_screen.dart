import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_awesome_generator/screens/qr_code_create_step_two_screen.dart';
// import 'qr_code_create_step_one_screen.dart';
import '/core/utils/locale_util.dart';
import '/core/utils/theme_util.dart';
import '/core/constants/app_assets.dart';
// import '/screens/home_screen.dart';

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
          // Get.offAll(() => const HomeScreen());
          Get.offAll(() => const QrCodeCreateStepTwoScreen());
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
      backgroundColor: Colors.white,
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
