// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TaskSwitch extends StatelessWidget {
  TaskSwitch({super.key, required this.isDone, required this.onTap});
  bool isDone = true;
  Function(bool value) onTap;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeTrackColor: Color(0xFF15B86C),
      value: isDone,
      onChanged: (value) => onTap(value),
    );
  }
}
