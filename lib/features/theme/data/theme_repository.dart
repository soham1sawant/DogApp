import 'package:dog_app/features/theme/data/theme_data_provider.dart';

class ThemeRepository {
  final ThemeDataProvider themeDataProvider = ThemeDataProvider();

  bool getThemeData() {
    bool isDarkTheme = themeDataProvider.getRawThemeData();

    if (isDarkTheme) {
      return true;
    } else {
      return false;
    }
  }
}
