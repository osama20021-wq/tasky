// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  InputFieldWidget({
    super.key,
    required this._maxLine,
    required this._fieldName,
    required this._controller,
    this.addBorder = false,
  });
  final int _maxLine;
  final String _fieldName;
  final TextEditingController _controller;
  bool addBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Color(0xFFFFFCFC)),
      controller: _controller,
      maxLines: _maxLine,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: addBorder == false
              ? BorderSide.none
              : BorderSide(color: Color(0xFF6E6E6E)),
        ),
        hintText: _fieldName,
        hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
        filled: true,
        fillColor: Color(0xFF282828),
      ),
      validator: _maxLine != 1
          ? null
          : (value) {
              if (value == null || value.trim().isEmpty) {
                return "Required";
              } else {
                return null;
              }
            },
    );
  }
}
