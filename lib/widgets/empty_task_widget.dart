import 'package:flutter/material.dart';
import 'package:flutter_application_4/widgets/user_welcome_widget.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({
    super.key,
    this.username,
    this.pageTitle,
    required this.emptyTaskMessage,
  });
  final String? username;
  final String? pageTitle;
  final String emptyTaskMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        username != null
            ? UserWelcomeWidget(username: username ?? "")
            : Text(
                pageTitle ?? "",
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
        Expanded(
          child: Center(
            child: Text(
              emptyTaskMessage,
              style: TextStyle(
                color: Color(0xFFFFFCFC),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
