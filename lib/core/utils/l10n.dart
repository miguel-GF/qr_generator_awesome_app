import 'package:get/get.dart';

class L10n extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'tabFavorites': 'Favorites',
          'tabSettings': 'Settings',
          'labelThemeLight': 'Light',
          'labelThemeDark': 'Dark',
        },
        'es_MX': {
          'tabFavorites': 'Favoritos',
          'tabSettings': 'Configuraciones',
          'labelThemeLight': 'Claro',
          'labelThemeDark': 'Oscuro',
        }
      };
}
