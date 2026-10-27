// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/themes/theme_controller.dart';
import 'package:flutter_application_4/models/task_model.dart';

class HighPriorityWidget extends StatelessWidget {
  HighPriorityWidget({
    super.key,
    required this.highPriority,
    required this.onTap,
  });

  List<TaskModel> highPriority;
  Function(bool? value, int index) onTap;
  @override
  Widget build(BuildContext context) {
    return highPriority.where((element) => element.isHighPriority).isNotEmpty
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: ThemeController().isDark()
                  ? null
                  : BoxBorder.all(color: Color(0xFFD1DAD6)),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4,
                  ),
                  child: Text(
                    "High Priority Tasks",
                    style: TextStyle(color: Color(0xFF15B86C), fontSize: 14),
                  ),
                ),
                ...highPriority.reversed
                    .where((element) => element.isHighPriority)
                    .take(4)
                    .map((e) {
                      return Row(
                        children: [
                          Checkbox(
                            checkColor: Color(0xFFFFFFFF),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            activeColor: const Color(0xFF15B86C),
                            value: e.isDone,
                            onChanged: (bool? value) async {
                              int index = highPriority.indexWhere(
                                (element) => element.taskId == e.taskId,
                              );
                              onTap(value, index);
                            },
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              e.taskName,
                              style: TextStyle(
                                color: e.isDone
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).primaryColorLight,
                                fontWeight: FontWeight.w400,
                                decoration: e.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Color(0xFFA0A0A0),
                                decorationThickness: 1.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          )
        : SizedBox();
  }
}
