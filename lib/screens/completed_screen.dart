import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_application_4/widgets/tasks_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> completedTask = [];
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
        completedTask = (jsonDecode(getSharedPref) as List)
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isDone)
            .toList();
      });
    }
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
                "Compeleted Tasks",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Expanded(
            child: completedTask.isEmpty
                ? Center(
                    child: Text(
                      "No tasks compeleted",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        TasksList(
                          tasks: completedTask,
                          onTap: (isDone, index) {},
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
