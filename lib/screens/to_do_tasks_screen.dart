// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ToDoTasksScreen extends StatefulWidget {
  const ToDoTasksScreen({super.key});

  @override
  State<ToDoTasksScreen> createState() => _ToDoTasksScreenState();
}

class _ToDoTasksScreenState extends State<ToDoTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Welcome To Tasky to do ",
        style: TextStyle(
          fontSize: 24,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
