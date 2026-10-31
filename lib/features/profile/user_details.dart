// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';
import 'package:flutter_application_4/screens/main_screen.dart';
import 'package:flutter_application_4/core/widget/custome_elevated_button.dart';
import 'package:flutter_application_4/core/widget/custome_text_form_field_widget.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key, required this.username});
  final String username;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _motivationController = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userNameController.text = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF181818),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 4),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: CustomeElevatedButton(
              title: "Save Changes",
              onTap: () async {
                if (_form.currentState?.validate() ?? false) {
                  await PrefrenceManager().setString(
                    "username",
                    _userNameController.text,
                  );
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                }
              },
            ),
          ),
        ),
        appBar: AppBar(title: Text("User Details")),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // add user name
                    CustomeTextFormFieldWidget(
                      title: "User Name",
                      maxLine: 1,
                      fieldName: "e.g. Sarah Khalid",
                      controller: _userNameController,
                      addBorder: true,
                    ),
                    SizedBox(height: 20),

                    // add Motivation Quote
                    CustomeTextFormFieldWidget(
                      title: "Motivation Quote",
                      maxLine: 5,
                      fieldName: "One task at a time. One step closer.",
                      controller: _motivationController,
                      addBorder: true,
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
