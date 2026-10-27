import 'package:flutter/material.dart';

class CustomeElevatedButton extends StatelessWidget {
  const CustomeElevatedButton({
    super.key,
    required this.title,
    required this.onTap,
    this._icon,
  });
  final String title;
  final Function onTap;
  final Icon? _icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async => onTap(),
      label: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      icon: _icon,
    );
  }
}
