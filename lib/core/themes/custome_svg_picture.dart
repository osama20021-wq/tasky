import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomeSvgPicture extends StatelessWidget {
  const CustomeSvgPicture({
    super.key,
    required this.path,
    required this.height,
    required this.width,
    this.withCOlor = true,
  });

  const CustomeSvgPicture.withoutColor({
    super.key,
    required this.path,
    required this.height,
    required this.width,
  }) : withCOlor = false;
  final String path;
  final double height;
  final double width;
  final bool withCOlor;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      colorFilter: withCOlor
          ? ColorFilter.mode(
              Theme.of(context).secondaryHeaderColor,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
