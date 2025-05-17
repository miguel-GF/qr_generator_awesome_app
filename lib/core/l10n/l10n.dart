import 'package:get/get.dart';

import './qr_code/l10n_qr_code_create_step_one.dart';
import './qr_code/l10n_qr_code_create_success.dart';
import './qr_code/l10n_tab_favorite.dart';
import './locale/l10n_locale_countries.dart';
import './settings/l10n_settings.dart';
import './cards/l10n_card_create_step_one.dart';

class L10n extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'titleHome': 'Qr Generator Awesome',
          'tabFavorites': 'Favorites',
          'tabCards': 'Cards',
          'tabSettings': 'Settings',
          'labelThemeLight': 'Light',
          'labelThemeDark': 'Dark',
          ...l10nQrCodeCreateStepOne['en_US']!,
          ...l10nQrCodeCreateSuccess['en_US']!,
          ...l10nTabFavorite['en_US']!,
          ...l10nLocaleCountries['en_US']!,
          ...l10nSettings['en_US']!,
          ...l10nCardCreateStepOne['en_US']!,
        },
        'es_MX': {
          'titleHome': 'Qr Generator Awesome',
          'tabFavorites': 'Favoritos',
          'tabCards': 'Tarjetas',
          'tabSettings': 'Configuraciones',
          'labelThemeLight': 'Claro',
          'labelThemeDark': 'Oscuro',
          ...l10nQrCodeCreateStepOne['es_MX']!,
          ...l10nQrCodeCreateSuccess['es_MX']!,
          ...l10nTabFavorite['es_MX']!,
          ...l10nLocaleCountries['es_MX']!,
          ...l10nSettings['es_MX']!,
          ...l10nCardCreateStepOne['es_MX']!,
        },
      };
}
