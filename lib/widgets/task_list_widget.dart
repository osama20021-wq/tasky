// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/enums/task_item_action_enum.dart';
import 'package:flutter_application_4/core/themes/theme_controller.dart';
import 'package:flutter_application_4/models/task_model.dart';

class TaskListWidget extends StatelessWidget {
  TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onTapDelete,
  });
  final List<TaskModel> tasks;
  Function(bool? value, int index) onTap;
  Function(int index) onTapDelete;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: ThemeController().isDark()
                ? null
                : BoxBorder.all(color: Color(0xFFD1DAD6)),
            color: Theme.of(context).cardColor,
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(width: 4),
              Checkbox(
                activeColor: Color(0xFF15B86C),
                checkColor: Color(0xFFFFFFFF),
                value: tasks[index].isDone,
                onChanged: (value) async => await onTap(value, index),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tasks[index].taskName,
                      style: TextStyle(
                        fontSize: 16,
                        color: tasks[index].isDone
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w400,
                        decoration: tasks[index].isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Color(0xFFA0A0A0),
                        decorationThickness: 1.5,
                      ),

                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    if (tasks[index].isDone == false &&
                        tasks[index].taskDescription.isNotEmpty)
                      Text(
                        tasks[index].taskDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
              PopupMenuButton<TaskItemActionEnum>(
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: tasks[index].isDone
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark,
                ),
                onSelected: (value) async {
                  switch (value) {
                    case TaskItemActionEnum.delete:
                      {
                        await onTapDelete(index);
                      }

                    case TaskItemActionEnum.edit:
                  }
                },
                position: PopupMenuPosition.under,

                itemBuilder: (context) => [
                  ...TaskItemActionEnum.values.map((e) {
                    return PopupMenuItem(value: e, child: Text(e.name));
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
