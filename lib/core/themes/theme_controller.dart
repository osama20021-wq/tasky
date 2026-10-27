import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  void init() {
    bool result = PrefrenceManager().getBool("theme") ?? true;

    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  Future toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PrefrenceManager().setBool("theme", false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PrefrenceManager().setBool("theme", true);
    }
  }

  bool isDark() => themeNotifier.value == ThemeMode.dark;
}
