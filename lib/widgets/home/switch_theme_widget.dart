import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../utils/util_app.dart';

class SwitchThemeWidget extends StatefulWidget {
  const SwitchThemeWidget({super.key});

  @override
  State<SwitchThemeWidget> createState() => _SwitchThemeWidgetState();
}

class _SwitchThemeWidgetState extends State<SwitchThemeWidget> {
  bool value = UtilApp.isDarkMode();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('labelThemeLight'.tr),
        const SizedBox(width: 8),
        Switch(
          value: value,
          thumbIcon:
              WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
            if (UtilApp.isDarkMode()) {
              return const Icon(Icons.dark_mode_rounded);
            }
            return const Icon(Icons.light_mode_rounded);
          }),
          onChanged: (_) {
            UtilApp.changeTheme();
            setState(() {
              value = !value;
            });
          },
        ),
        const SizedBox(width: 8),
        Text('labelThemeDark'.tr),
      ],
    );
  }
}
