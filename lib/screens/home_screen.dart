import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_application_4/screens/add_task_screen.dart';
import 'package:flutter_application_4/widgets/achived_task.dart';
import 'package:flutter_application_4/core/widget/custome_elevated_button.dart';
import 'package:flutter_application_4/widgets/empty_task_widget.dart';
import 'package:flutter_application_4/widgets/high_priority_widget.dart';
import 'package:flutter_application_4/widgets/task_list_widget.dart';
import 'package:flutter_application_4/widgets/user_welcome_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  int totalTask = 0;
  int achivedTask = 0;
  double persentage = 0;
  List<TaskModel> tasks = [];

  Future _getUsername() async {
    setState(() {
      username = PrefrenceManager().getString("username") ?? "guest";
    });
  }

  Future _getTasks() async {
    final getSharedPref = PrefrenceManager().getString("allTasks");
    if (getSharedPref != null) {
      setState(() {
        tasks = (jsonDecode(getSharedPref) as List)
            .map((e) => TaskModel.fromJson(e))
            .toList();
        _calculate();
      });
    }
  }

  void _calculate() {
    totalTask = tasks.length;
    achivedTask = tasks.where((element) => element.isDone).length;
    persentage = totalTask != 0 ? (achivedTask / totalTask) : 0;
  }

  void _changeBox(bool? value, int index) async {
    setState(() {
      tasks[index].isDone = value ?? false;
      _calculate();
    });
    await PrefrenceManager().setString("allTasks", jsonEncode(tasks));
  }

  @override
  void initState() {
    _getUsername();
    _getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        width: 167,
        child: CustomeElevatedButton(
          title: "Add New Task",
          onTap: () async {
            bool? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()),
            );
            if (result != null || result == true) {
              _getTasks();
            }
          },
          icon: Icon(Icons.add),
        ),
      ),
      body: tasks.isNotEmpty
          ? CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: UserWelcomeWidget(username: username, tasks: tasks),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AchivedTask(
                          totalTask: totalTask,
                          achivedTask: achivedTask,
                          persentage: persentage,
                        ),
                        SizedBox(height: 8),

                        HighPriorityWidget(
                          highPriority: tasks,
                          onTap: (value, index) async {
                            _changeBox(value, index);
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          "My Tasks",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                TaskListWidget(
                  tasks: tasks,
                  onTap: (value, index) {
                    _changeBox(value, index);
                  },
                ),
                SliverToBoxAdapter(child: SizedBox(height: 60)),
              ],
            )
          : EmptyTaskWidget(username: username, emptyTaskMessage: "No Tasks"),
    );
  }
}
