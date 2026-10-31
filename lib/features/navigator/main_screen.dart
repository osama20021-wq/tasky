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
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Theme.of(context).brightness,
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int? value) {
            setState(() {
              _currentIndex = value ?? 0;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: _svgPicture("images/Icon-home.svg", 0),
            ),
            BottomNavigationBarItem(
              label: "To Do",
              icon: _svgPicture("images/Icon-todo.svg", 1),
            ),
            BottomNavigationBarItem(
              label: "Completed",
              icon: _svgPicture("images/Icon-completed.svg", 2),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: _svgPicture("images/Icon-person.svg", 3),
            ),
          ],
        ),
        body: SafeArea(child: screens[_currentIndex]),
      ),
    );
  }

  SvgPicture _svgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index
            ? Color(0xFF15B86C)
            : Theme.of(context).secondaryHeaderColor,
        BlendMode.srcIn,
      ),
    );
  }
}
