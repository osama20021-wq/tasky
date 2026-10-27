import 'package:flutter/material.dart';

class CustomeListTileWidget extends StatelessWidget {
  const CustomeListTileWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.leading,
    required this.trailing,
  });
  final String title;
  final Function onTap;
  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,

      onTap: () => onTap(),
      leading: leading,
      title: Text(title),
      trailing: trailing,
    );
  }
}
