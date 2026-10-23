import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_application_4/widgets/empty_task_widget.dart';
import 'package:flutter_application_4/widgets/task_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoTaskScreen extends StatefulWidget {
  const ToDoTaskScreen({super.key});

  @override
  State<ToDoTaskScreen> createState() => _ToDoTaskScreenState();
}

class _ToDoTaskScreenState extends State<ToDoTaskScreen> {
  List<TaskModel> _toDoTasks = [];

  Future _getTasks() async {
    final sharedPref = await SharedPreferences.getInstance();
    final getSharedPref = sharedPref.getString("allTasks");
    if (getSharedPref != null) {
      setState(() {
        _toDoTasks = (jsonDecode(getSharedPref) as List)
            .map((e) => TaskModel.fromJson(e))
            .where((element) => !element.isDone)
            .toList();
      });
    }
  }

  @override
  void initState() {
    _getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _toDoTasks.isNotEmpty
        ? CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "To Do Tasks",
                        style: TextStyle(
                          color: Color(0xFFFFFCFC),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              TaskListWidget(
                tasks: _toDoTasks,
                onTap: (value, index) async {
                  final sharedPref = await SharedPreferences.getInstance();
                  final getSharedPref = sharedPref.getString("allTasks");
                  setState(() {
                    _toDoTasks[index].isDone = value ?? false;
                  });
                  if (getSharedPref != null) {
                    List<TaskModel> updatedTask = (jsonDecode(
                      getSharedPref,
                    ) as List).map((e) => TaskModel.fromJson(e)).toList();
                    int currentIndex = updatedTask.indexWhere(
                      (element) => element.taskId == updatedTask[index].taskId,
                    );

                    updatedTask[currentIndex] = _toDoTasks[index];
                    await sharedPref.setString(
                      "allTasks",
                      jsonEncode(updatedTask),
                    );
                    _getTasks();
                  }
                },
              ),
            ],
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: EmptyTaskWidget(
              pageTitle: "To Do Tasks",
              emptyTaskMessage: "No Tasks to do",
            ),
          );
  }
}
