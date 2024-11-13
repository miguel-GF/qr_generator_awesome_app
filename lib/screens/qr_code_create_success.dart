import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_translations_keys/qr_code_create_success_traslations_keys.dart';
import '../core/routes/routes_names.dart';
import '../core/widgets/bottom_bar_widget.dart';
import '../core/widgets/lottie_widget.dart';

class QrCodeCreateSuccess extends StatelessWidget {
  const QrCodeCreateSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    QrCodeCreateSuccessTranslationsKeys trKey =
        QrCodeCreateSuccessTranslationsKeys();
    void goHome() {
      Get.offAllNamed(nameHomeScreen);
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        {
          if (didPop) {
            return goHome();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(trKey.title.tr),
          leading: IconButton(
            onPressed: () => goHome(),
            icon: const Icon(Icons.arrow_back), 
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: LottieWidget(
                  numberRepeat: 1,
                  seconds: 4,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                trKey.message.tr,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 12),
              Text(
                trKey.subMessage.tr,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBarWidget(
          labelBtn: trKey.btnAction.tr,
          function: () async => goHome(),
        ),
      ),
    );
  }
}
