// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';
import 'package:flutter_application_4/core/themes/custome_svg_picture.dart';
import 'package:flutter_application_4/screens/main_screen.dart';
import 'package:flutter_application_4/core/widget/custome_elevated_button.dart';
import 'package:flutter_application_4/core/widget/custome_text_form_field_widget.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Theme.of(context).brightness,
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
                              CustomeSvgPicture.withoutColor(
                                path: "images/Vector.svg",
                                height: 42,
                                width: 42,
                              ),
                              SizedBox(width: 9),
                              Text(
                                "Tasky",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(fontSize: 28),
                              ),
                            ],
                          ),
                          SizedBox(height: 108),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome To Tasky ",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(fontSize: 24),
                              ),
                              CustomeSvgPicture.withoutColor(
                                path: "images/waving-hand.svg",
                                height: 28,
                                width: 28,
                              ),
                            ],
                          ),
                          Text(
                            "Your productivity journey starts here.",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 24),
                          CustomeSvgPicture.withoutColor(
                            path: "images/pana.svg",
                            height: 205,
                            width: 215,
                          ),
                          SizedBox(height: 28),
                        ],
                      ),
                    ),

                    // add name
                    CustomeTextFormFieldWidget(
                      title: "Full Name",
                      maxLine: 1,
                      fieldName: "e.g. Sarah Khalid",
                      controller: _controller,

                      //      addBorder: true,
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: CustomeElevatedButton(
                        title: "Let’s Get Started",
                        onTap: () async {
                          if (_key.currentState?.validate() ?? false) {
                            PrefrenceManager().setString(
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
