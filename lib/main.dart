import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'screens/error_screen.dart';
import 'screens/splash_screen.dart';
import 'core/themes/app_theme.dart';
import 'core/database/local/database_helper.dart';
import 'core/utils/l10n.dart';
import 'core/routes/routes_pages.dart';
// import 'features/qr_code/data/data_sources/local/qr_code_database_helper.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Se define horientación vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inicializa la base de datos
  final DatabaseHelper dbHelper = DatabaseHelper();
  await dbHelper.database;

  //  if (database != null) {
  //   print('Base de datos inicializada exitosamente');
  // } else {
  //   print('Error al inicializar la base de datos');
  // }

  // final codes = await QrCodeDatabaseHelper().getQrCodes();
  //Se define estilo para la barra de estado
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarIconBrightness: Brightness.dark,
  //   statusBarColor: Colors.grey[400], // status bar color
  // ));
  // HttpOverrides.global = CustomHttpoverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      title: 'QR GENERATOR AWESOME',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) =>
            ErrorScreen(errorDetails: errorDetails);
        return widget!;
      },
      translations: L10n(),
      home: const SplashScreen(),
      getPages: getPages,
    );
  }
}
