import 'package:flutter/material.dart';
import '/utils/util_app.dart';
import '/widgets/home/switch_theme_widget.dart';

class HomeSettingsWidget extends StatelessWidget {
  const HomeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SwitchThemeWidget(
              key: UniqueKey(),
            ),
          ],
        ),
        TextButton(
          onPressed: () => UtilApp.changeLocale('en_US'),
          child: const Text('cambiar idioma'),
        ),
      ],
    );
  }
}
