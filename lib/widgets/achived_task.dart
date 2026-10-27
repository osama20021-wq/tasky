// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/themes/theme_controller.dart';

class AchivedTask extends StatelessWidget {
  AchivedTask({
    super.key,
    required this.totalTask,
    required this.achivedTask,
    required this.persentage,
  });
  int totalTask;
  int achivedTask;
  double persentage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: ThemeController().isDark()
            ? null
            : BoxBorder.all(color: Color(0xFFD1DAD6)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "$achivedTask Out of $totalTask Done",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Spacer(),
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: CircularProgressIndicator(
                  strokeAlign: 1.5,
                  backgroundColor: Color(0xFF6D6D6D),
                  value: persentage,
                  color: Color(0xFF15B86C),
                ),
              ),
              Text(
                "${(persentage * 100).toInt()}%",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
