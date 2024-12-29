import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/constants/app_translations_keys/settings_translations_keys.dart';
import '/widgets/home/switch_theme_widget.dart';
import '/widgets/settings/setting_item_widget.dart';

class HomeSettingsWidget extends StatelessWidget {
  const HomeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsTranslationsKeys trKey =
        SettingsTranslationsKeys();
    final List<Map<String, dynamic>> options = [
      {
        'title': trKey.nameLanguage.tr,
        'icon': Icons.language_outlined,
        'value': 'language',
      },
      {
        'title': trKey.namePurchase.tr,
        'icon': Icons.shop_two_outlined,
        'value': 'purchase',
      }
    ];
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
        ListView.separated(
          shrinkWrap: true,
          itemCount: options.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final option = options[index];
            return SettingItemWidget(
              title: option['title'],
              icon: option['icon'],
              value: option['value'],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ],
    );
  }
}
