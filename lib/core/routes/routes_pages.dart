import 'package:get/get.dart';

import '../../screens/home_screen.dart';
import '../../screens/qr_code_create_step_one_screen.dart';
import '../../screens/qr_code_create_step_two_screen.dart';
import '../../screens/qr_code_create_success.dart';
import '../../screens/business_card_create_screen.dart';
import '../../screens/business_card_create_step_two_screen.dart';
import '../../screens/business_card_create_step_three_screen.dart';
import 'routes_names.dart';

final getPages = [
  // Aquí defines tus rutas
  GetPage(name: nameHomeScreen, page: () => const HomeScreen()),
  GetPage(
      name: nameCreateQrCodeStepOneScreen,
      page: () => const QrCodeCreateStepOneScreen()),
  GetPage(
      name: nameCreateQrCodeStepTwoScreen,
      page: () => const QrCodeCreateStepTwoScreen()),
  GetPage(
      name: nameCreateQrCodeSuccess, page: () => const QrCodeCreateSuccess()),
  GetPage(
    name: nameCreateBusinessCard,
    page: () => const BusinessCardCreateScreen(),
  ),
  GetPage(
    name: nameCreateBusinessCardStepTwo,
    page: () => const BusinessCardCreateStepTwoScreen(),
  ),
  GetPage(
    name: nameCreateBusinessCardStepThree,
    page: () => const BusinessCardCreateStepThreeScreen(),
  ),
];
