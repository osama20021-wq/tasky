import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/screens/compelete_task_screen.dart';
import 'package:flutter_application_4/screens/home_screen.dart';
import 'package:flutter_application_4/screens/profile_screen.dart';
import 'package:flutter_application_4/screens/to_do_task_screen.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    ToDoTaskScreen(),
    CompeleteTaskScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF181818),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF181818),
          selectedItemColor: Color(0xFF15B86C),
          unselectedItemColor: Color(0xFFFFFCFC),
          currentIndex: _currentIndex,
          onTap: (int? value) {
            setState(() {
              _currentIndex = value ?? 0;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: SvgPicture.asset(
                "images/Icon-home.svg",
                colorFilter: ColorFilter.mode(
                  _currentIndex == 0 ? Color(0xFF15B86C) : Color(0xFFFFFCFC),
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "To Do",
              icon: SvgPicture.asset(
                "images/Icon-todo.svg",
                colorFilter: ColorFilter.mode(
                  _currentIndex == 1 ? Color(0xFF15B86C) : Color(0xFFFFFCFC),
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Completed",
              icon: SvgPicture.asset(
                "images/Icon-completed.svg",
                colorFilter: ColorFilter.mode(
                  _currentIndex == 2 ? Color(0xFF15B86C) : Color(0xFFFFFCFC),
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: SvgPicture.asset(
                "images/Icon-person.svg",
                colorFilter: ColorFilter.mode(
                  _currentIndex == 3 ? Color(0xFF15B86C) : Color(0xFFFFFCFC),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(child: screens[_currentIndex]),
      ),
    );
  }
}
