import 'package:flutter/material.dart';
import 'package:qr_awesome_generator/utils/util_app.dart';

class HomeSettingsWidget extends StatelessWidget {
  const HomeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text('Settings'),
        ),
        const TextButton(
          onPressed: UtilApp.changeTheme,
          child: Text('cambiar tema'),
        ),
        TextButton(
          onPressed: () => UtilApp.changeLocale('en_US'),
          child: const Text('cambiar idioma'),
        ),
      ],
    );
  }
}
