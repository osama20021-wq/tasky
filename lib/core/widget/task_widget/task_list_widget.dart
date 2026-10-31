// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/enums/task_item_action_enum.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';
import 'package:flutter_application_4/core/themes/theme_controller.dart';
import 'package:flutter_application_4/core/widget/custome_elevated_button.dart';
import 'package:flutter_application_4/core/widget/custome_text_form_field_widget.dart';
import 'package:flutter_application_4/core/widget/task_switch_widget.dart';
import 'package:flutter_application_4/models/task_model.dart';

class TaskListWidget extends StatelessWidget {
  TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTapDone,
    required this.onTapDelete,
    required this.onTapEdit,
  });
  final List<TaskModel> tasks;
  Function(bool? value, int index) onTapDone;
  Function(int index) onTapDelete;
  Function onTapEdit;

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
                onChanged: (value) async => await onTapDone(value, index),
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
                        await _showDialog(context, index);
                      }
                    case TaskItemActionEnum.Done:
                      {
                        await onTapDone(!tasks[index].isDone, index);
                      }
                    case TaskItemActionEnum.edit:
                      {
                        final bool? result = await _showModalBottomSheet(
                          context,
                          tasks,
                          index,
                        );
                        if (result == true) {
                          await onTapEdit();
                        }
                      }
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

  Future<bool?> _showModalBottomSheet(
    BuildContext context,
    List<TaskModel> tasks,
    int index,
  ) async {
    GlobalKey<FormState> form = GlobalKey<FormState>();
    TextEditingController taskNameController = TextEditingController(
      text: tasks[index].taskName,
    );
    TextEditingController taskDescController = TextEditingController(
      text: tasks[index].taskDescription,
    );

    return showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,

      context: context,
      builder: (context) {
        bool isHighPriority = tasks[index].isHighPriority;
        List<TaskModel> allTasks = [];
        return StatefulBuilder(
          builder: (context, setState) {
            final getSharedPref = PrefrenceManager().getString("allTasks");
            if (getSharedPref != null) {
              setState(() {
                allTasks = (jsonDecode(getSharedPref) as List)
                    .map((e) => TaskModel.fromJson(e))
                    .toList();
              });
            }
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * (2 / 3),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 10,
                ),
                child: Form(
                  key: form,
                  child: Column(
                    children: [
                      Text(
                        "Edit Task",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      // task name
                      CustomeTextFormFieldWidget(
                        title: "Task Name",
                        maxLine: 1,
                        fieldName: "Finish UI design for login screen",
                        controller: taskNameController,
                      ),
                      SizedBox(height: 20),

                      // Task Description
                      CustomeTextFormFieldWidget(
                        title: "Task Description",
                        maxLine: 5,
                        fieldName: "Finish onboarding UI and hand off to devs by Thursday.",
                        controller: taskDescController,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "High Priority  ",
                            style: Theme.of(context).textTheme.bodyLarge!,
                          ),
                          Spacer(),
                          TaskSwitchWidget(
                            isDone: isHighPriority,
                            onTap: (value) {
                              setState(() {
                                isHighPriority = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: CustomeElevatedButton(
                          icon: Icon(Icons.edit),
                          title: "Edit Task",
                          onTap: () async {
                            if (form.currentState?.validate() ?? false) {
                              int currentIndex = allTasks.indexWhere(
                                (element) =>
                                    element.taskId == tasks[index].taskId,
                              );

                              allTasks[currentIndex].taskName =
                                  taskNameController.text;
                              allTasks[currentIndex].taskDescription =
                                  taskDescController.text;
                              allTasks[currentIndex].isHighPriority =
                                  isHighPriority;

                              await PrefrenceManager().setString(
                                "allTasks",
                                jsonEncode(allTasks),
                              );
                              Navigator.of(context).pop(true);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future _showDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            "Delete Task",
            style: Theme.of(context).textTheme.bodyLarge!
                .copyWith(fontSize: 25),
          ),
          content: Text(
            "Are you sure you want to delete this task?",
            style: Theme.of(context).textTheme.bodyLarge!
                .copyWith(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await onTapDelete(index);
                Navigator.pop(context);
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
