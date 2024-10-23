import 'package:get/get.dart';

import './qr_code/l10n_qr_code_create_step_one.dart';

class L10n extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'tabFavorites': 'Favorites',
          'tabSettings': 'Settings',
          'labelThemeLight': 'Light',
          'labelThemeDark': 'Dark',
          ...l10nQrCodeCreateStepOne['en_US']!,
        },
        'es_MX': {
          'tabFavorites': 'Favoritos',
          'tabSettings': 'Configuraciones',
          'labelThemeLight': 'Claro',
          'labelThemeDark': 'Oscuro',
          ...l10nQrCodeCreateStepOne['es_MX']!,
        },
      };
}
