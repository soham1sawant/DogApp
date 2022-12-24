import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class ThemeDataProvider {
  bool getRawThemeData() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return isDarkMode;
  }
}
