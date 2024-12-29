import 'package:flutter/material.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:get/get.dart';
import 'package:qr_awesome_generator/core/utils/locale_util.dart';

import '../../core/constants/app_translations_keys/settings_translations_keys.dart';

class SettingItemWidget extends StatefulWidget {
  const SettingItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });
  final String title;
  final IconData icon;
  final String value;

  @override
  State<SettingItemWidget> createState() => _SettingItemWidgetState();
}

class _SettingItemWidgetState extends State<SettingItemWidget> {
  SettingsTranslationsKeys trKey = SettingsTranslationsKeys();
  void onOptionTap() {
    if (widget.value == 'language') {
      DropDownState(
        dropDown: DropDown(
          bottomSheetTitle: Text(
            trKey.nameTitleChangeLanguage.tr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          // submitButtonText: 'Save',
          // clearButtonText: 'Clear',
          data: LocaleUtil.getCountries(),
          onSelected: (List<dynamic> selectedList) {
            for (var item in selectedList) {
              if (item is SelectedListItem) {
                LocaleUtil.changeLocale(item.value!);
              }
            }
          },
          maxSelectedItems: 1,
          isSearchVisible: false,
        ),
      ).showModal(Get.context!);
    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onOptionTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(widget.title),
            ),
            Icon(widget.icon),
          ],
        ),
      ),
    );
  }
}
