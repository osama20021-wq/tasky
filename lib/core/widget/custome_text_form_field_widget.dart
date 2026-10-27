// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomeTextFormFieldWidget extends StatelessWidget {
  CustomeTextFormFieldWidget({
    super.key,
    required this.title,
    required this._maxLine,
    required this._fieldName,
    required this._controller,
    this.addBorder = false,
  });
  final String title;
  final int _maxLine;
  final String _fieldName;
  final TextEditingController _controller;
  bool addBorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: 8),
        TextFormField(
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          controller: _controller,
          maxLines: _maxLine,
          decoration: InputDecoration(hintText: _fieldName),

          validator: _maxLine == 1
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                }
              : null,
        ),
      ],
    );
  }
}
