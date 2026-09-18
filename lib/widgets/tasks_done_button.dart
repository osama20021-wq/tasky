import 'package:flutter/material.dart';

class TasksDoneButton extends StatelessWidget {
  const TasksDoneButton({
    super.key,
    required this._label,
    required this._function,
    this._icon,
  });
  final String _label;
  final Function _function;
  final Icon? _icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF15B86C),
        foregroundColor: Color(0xFFFFFCFC),
        padding: EdgeInsets.zero,
      ),
      onPressed: () async {
        _function();
      },
      label: Text(_label),
      icon: _icon,
    );
  }
}
