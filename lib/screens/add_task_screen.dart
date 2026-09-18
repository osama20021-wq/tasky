// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_application_4/widgets/task_input_field.dart';
import 'package:flutter_application_4/widgets/task_switch.dart';
import 'package:flutter_application_4/widgets/tasks_done_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: TasksDoneButton(
            label: "Add Task",
            function: () async {
              final sharedPref = await SharedPreferences.getInstance();
              final getSharedPref = sharedPref.getString("allTasks");
              List<dynamic> tasks = [];
              if (getSharedPref != null) {
                tasks = jsonDecode(getSharedPref);
              }
              TaskModel taskModel = TaskModel(
                taskId: tasks.length + 1,
                taskName: _taskNameController.text,
                taskDescription: _taskDescriptionController.text,
                isHighPriority: isHighPriority,
              );
              tasks.add(taskModel.toJson());
              await sharedPref.setString("allTasks", jsonEncode(tasks));
              Navigator.of(context).pop(true);
            },
            icon: Icon(Icons.add),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task Name",
                  style: TextStyle(
                    color: Color(0xFFFFFCFC),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                TaskInputField(
                  controller: _taskNameController,
                  hintText: "Finish UI design for login screen",
                ),
                SizedBox(height: 20),
                Text(
                  "Task Description",
                  style: TextStyle(
                    color: Color(0xFFFFFCFC),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                TaskInputField(
                  maxline: 5,
                  controller: _taskDescriptionController,
                  hintText:
                      "Finish onboarding UI and hand off to devs by Thursday.",
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "High Priority",
                      style: TextStyle(
                        color: Color(0xFFFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    TaskSwitch(
                      isDone: isHighPriority,
                      onTap: (value) {
                        setState(() {
                          isHighPriority = value;
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
    );
  }
}
