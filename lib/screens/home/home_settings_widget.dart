import 'package:flutter/material.dart';
import 'package:qr_awesome_generator/utils/util_app.dart';

class HomeSettingsWidget extends StatelessWidget {
  const HomeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text('Settings'),
        ),
        TextButton(
          onPressed: UtilApp.changeTheme,
          child: Text('cambiar tema'),
        ),
      ],
    );
  }
}
