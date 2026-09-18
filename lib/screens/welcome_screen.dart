// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/screens/main_screen.dart';
import 'package:flutter_application_4/widgets/task_input_field.dart';
import 'package:flutter_application_4/widgets/tasks_done_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF181818),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "images/Vector.svg",
                          height: 42,
                          width: 42,
                        ),

                        SizedBox(width: 6),
                        Text(
                          "Tasky",
                          style: TextStyle(
                            fontSize: 28,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 108),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome To Tasky ",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFFFFFCFC),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SvgPicture.asset(
                          "images/waving-hand.svg",
                          height: 28,
                          width: 28,
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        "Your productivity journey starts here.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFCFC),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: SvgPicture.asset(
                        "images/pana.svg",
                        width: 215,
                        height: 205,
                      ),
                    ),
                    SizedBox(height: 28),
                    Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFFFCFC),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    TaskInputField(
                      controller: _controller,
                      hintText: "e.g. Sarah Khalid",
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: TasksDoneButton(
                        label: "Let’s Get Started",
                        function: () async {
                          if (_key.currentState?.validate() ?? false) {
                            final sharedPref =
                                await SharedPreferences.getInstance();
                            await sharedPref.setString(
                              "username",
                              _controller.text,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
