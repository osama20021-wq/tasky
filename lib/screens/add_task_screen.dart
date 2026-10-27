// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_application_4/core/widget/custome_elevated_button.dart';
import 'package:flutter_application_4/core/widget/custome_text_form_field_widget.dart';
import 'package:flutter_application_4/core/widget/task_switch_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF181818),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 4),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: CustomeElevatedButton(
              icon: Icon(Icons.add),
              title: "Add Task",
              onTap: () async {
                if (_form.currentState?.validate() ?? false) {
                  final getSharedPref = PrefrenceManager().getString(
                    "allTasks",
                  );
                  List<dynamic> tasks = [];
                  if (getSharedPref != null) {
                    tasks = jsonDecode(getSharedPref);
                  }
                  TaskModel taskModel = TaskModel(
                    taskId: tasks.length + 1,
                    taskName: _taskNameController.text,
                    taskDescription: _taskDescController.text,
                    isHighPriority: _isHighPriority,
                  );
                  tasks.add(taskModel.toJson());
                  await PrefrenceManager().setString(
                    "allTasks",
                    jsonEncode(tasks),
                  );
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "New Task",
            style: Theme.of(context).textTheme.bodyLarge!
                .copyWith(fontSize: 20),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // task name
                  CustomeTextFormFieldWidget(
                    title: "Task Name",
                    maxLine: 1,
                    fieldName: "Finish UI design for login screen",
                    controller: _taskNameController,
                  ),
                  SizedBox(height: 20),

                  // Task Description
                  CustomeTextFormFieldWidget(
                    title: "Task Description",
                    maxLine: 5,
                    fieldName: "Finish onboarding UI and hand off to devs by Thursday.",
                    controller: _taskDescController,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "High Priority  ",
                        style: TextStyle(
                          color: Color(0xFFFFFCFC),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      TaskSwitchWidget(
                        isDone: _isHighPriority,
                        onTap: (value) {
                          setState(() {
                            _isHighPriority = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
