import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/screens/main_screen.dart';
import 'package:flutter_application_4/screens/welcome_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();
  final userName = sharedPref.getString("username");
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF181818),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFF181818),
          foregroundColor: Color(0xFFFFFCFC),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: userName == null ? WelcomeScreen() : MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF181818),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(body: MainScreen()),
    );
  }
}
