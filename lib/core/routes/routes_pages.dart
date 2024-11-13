import 'package:get/get.dart';

import '../../screens/home_screen.dart';
import '../../screens/qr_code_create_step_one_screen.dart';
import '../../screens/qr_code_create_step_two_screen.dart';
import '../../screens/qr_code_create_success.dart';
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
];
