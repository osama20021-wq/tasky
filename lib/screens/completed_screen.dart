import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/task_model.dart';
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
    return Center(
      child: Text(
        "Welcome To Tasky compeleted ",
        style: TextStyle(
          fontSize: 24,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
