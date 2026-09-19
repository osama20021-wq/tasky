// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_application_4/widgets/tasks_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoTasksScreen extends StatefulWidget {
  const ToDoTasksScreen({super.key});

  @override
  State<ToDoTasksScreen> createState() => _ToDoTasksScreenState();
}

class _ToDoTasksScreenState extends State<ToDoTasksScreen> {
  List<TaskModel> toDoTasks = [];
  @override
  void initState() {
    getTasks();
    super.initState();
  }

  Future getTasks() async {
    final sharedPref = await SharedPreferences.getInstance();
    final getSharedPref = sharedPref.getString("allTasks");
    if (getSharedPref != null) {
      setState(() {
        toDoTasks = (jsonDecode(getSharedPref) as List)
            .map((e) => TaskModel.fromJson(e))
            .where((element) => !element.isDone)
            .toList();
      });
    }
    print("tasks");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          SizedBox(height: 18),
          Row(
            children: [
              Text(
                "To Do Tasks",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Expanded(
            child: toDoTasks.isEmpty
                ? Center(
                    child: Text(
                      "There are no tasks to do",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        TasksList(tasks: toDoTasks, onTap: (isDone, index) {}),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
