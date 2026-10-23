// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';

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
        color: Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "$achivedTask Out of $totalTask Done",
                style: TextStyle(
                  color: Color(0xFFC6C6C6),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
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
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
