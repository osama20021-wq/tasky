import 'package:flutter/material.dart';

class DoneButtonWidget extends StatelessWidget {
  const DoneButtonWidget({
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
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: Color(0xFFFFFCFC),
        backgroundColor: Color(0xFF15B86C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(30),
        ),
      ),
      onPressed: () => onTap(),
      label: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      icon: _icon,
    );
  }
}
