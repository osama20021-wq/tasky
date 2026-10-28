import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';
import 'package:flutter_application_4/core/themes/dark_theme.dart';
import 'package:flutter_application_4/core/themes/light_theme.dart';
import 'package:flutter_application_4/core/themes/theme_controller.dart';
import 'package:flutter_application_4/screens/main_screen.dart';
import 'package:flutter_application_4/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrenceManager().init();
  ThemeController().init();

  String? username = PrefrenceManager().getString("username");

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});
  final String? username;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeController.themeNotifier.value,
          debugShowCheckedModeBanner: false,
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
