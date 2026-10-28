import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_application_4/widgets/empty_task_widget.dart';
import 'package:flutter_application_4/widgets/task_list_widget.dart';

class CompeleteTaskScreen extends StatefulWidget {
  const CompeleteTaskScreen({super.key});

  @override
  State<CompeleteTaskScreen> createState() => _CompeleteTaskScreenState();
}

class _CompeleteTaskScreenState extends State<CompeleteTaskScreen> {
  List<TaskModel> _compeleteTask = [];
  Future _getTasks() async {
    final getSharedPref = PrefrenceManager().getString("allTasks");
    if (getSharedPref != null) {
      setState(() {
        _compeleteTask = (jsonDecode(getSharedPref) as List)
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isDone)
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
    return _compeleteTask.isNotEmpty
        ? CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 18),
                  child: Column(
                    children: [
                      Text(
                        "Completed Tasks",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              TaskListWidget(
                tasks: _compeleteTask,
                onTap: (value, index) async {
                  final getSharedPref = PrefrenceManager().getString(
                    "allTasks",
                  );
                  setState(() {
                    _compeleteTask[index].isDone = value ?? false;
                  });

                  if (getSharedPref != null) {
                    List<TaskModel> updatedTask = (jsonDecode(
                      getSharedPref,
                    ) as List).map((e) => TaskModel.fromJson(e)).toList();
                    int taskIndex = updatedTask.indexWhere(
                      (element) =>
                          element.taskId == _compeleteTask[index].taskId,
                    );
                    updatedTask[taskIndex] = _compeleteTask[index];
                    await PrefrenceManager().setString(
                      "allTasks",
                      jsonEncode(updatedTask),
                    );
                    _getTasks();
                  }
                },
                onTapDelete: (index) async {
                  final getSharedPref = PrefrenceManager().getString(
                    "allTasks",
                  );
                  if (getSharedPref != null) {
                    List<TaskModel> updatedTask = (jsonDecode(
                      getSharedPref,
                    ) as List).map((e) => TaskModel.fromJson(e)).toList();
                    int currentIndex = updatedTask.indexWhere(
                      (element) =>
                          element.taskId == _compeleteTask[index].taskId,
                    );
                    setState(() {
                      updatedTask.removeAt(currentIndex);
                    });

                    await PrefrenceManager().setString(
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
              pageTitle: "Completed Tasks",
              emptyTaskMessage: "No Tasks Completed",
            ),
          );
  }
}
