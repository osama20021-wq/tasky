// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/screens/main_screen.dart';
import 'package:flutter_application_4/widgets/done_button_widget.dart';
import 'package:flutter_application_4/widgets/input_field_widget.dart';
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4,
              ),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "images/Vector.svg",
                                height: 42,
                                width: 42,
                              ),
                              SizedBox(width: 9),
                              Text(
                                "Tasky",
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 28,
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
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 24,
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
                          Text(
                            "Your productivity journey starts here.",
                            style: TextStyle(
                              color: Color(0xFFFFFCFC),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 24),
                          SvgPicture.asset(
                            "images/pana.svg",
                            height: 205,
                            width: 215,
                          ),
                          SizedBox(height: 28),
                        ],
                      ),
                    ),
                    // enter full name
                    Text(
                      "Full Name",
                      style: TextStyle(
                        color: Color(0xFFFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    // add name
                    InputFieldWidget(
                      maxLine: 1,
                      fieldName: "e.g. Sarah Khalid",
                      controller: _controller,
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: DoneButtonWidget(
                        title: "Let’s Get Started",
                        onTap: () async {
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
