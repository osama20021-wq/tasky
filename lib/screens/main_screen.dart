import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/screens/completed_screen.dart';
import 'package:flutter_application_4/screens/home_screen.dart';
import 'package:flutter_application_4/screens/profile_screen.dart';
import 'package:flutter_application_4/screens/to_do_tasks_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    ToDoTasksScreen(),
    CompletedTasksScreen(),
    ProfileScreen(),
  ];
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
          currentIndex: _index,
          selectedItemColor: Color(0xFF15B86C),
          unselectedItemColor: Color(0xFFC6C6C6),

          onTap: (int? value) {
            setState(() {
              _index = value ?? 0;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  _index == 0 ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
                  BlendMode.srcIn,
                ),
                "images/Icon-home.svg",
              ),
            ),
            BottomNavigationBarItem(
              label: "To Do",
              icon: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  _index == 1 ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
                  BlendMode.srcIn,
                ),
                "images/Icon-todo.svg",
              ),
            ),
            BottomNavigationBarItem(
              label: "Completed",
              icon: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  _index == 2 ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
                  BlendMode.srcIn,
                ),
                "images/Icon-completed.svg",
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  _index == 3 ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
                  BlendMode.srcIn,
                ),
                "images/Icon-person.svg",
              ),
            ),
          ],
        ),
        body: SafeArea(child: _screens[_index]),
      ),
    );
  }
}
