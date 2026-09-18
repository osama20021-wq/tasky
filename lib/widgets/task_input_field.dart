import 'package:flutter/material.dart';

class TaskInputField extends StatelessWidget {
  const TaskInputField({
    super.key,
    required this._controller,
    required this.hintText,
    this.maxline,
  });

  final TextEditingController _controller;
  final String hintText;
  final int? maxline;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxline ?? 1,
      controller: _controller,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF282828),
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Required";
        } else {
          return null;
        }
      },
    );
  }
}
