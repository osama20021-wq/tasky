// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_application_4/screens/add_task_screen.dart';
import 'package:flutter_application_4/widgets/high_priority.dart';
import 'package:flutter_application_4/widgets/tasks_done_button.dart';
import 'package:flutter_application_4/widgets/tasks_list.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  List<TaskModel> tasks = [];

  @override
  void initState() {
    getUsername();
    getTasks();
    super.initState();
  }

  Future getUsername() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPref.getString("username") ?? "Guest";
    });
  }

  Future getTasks() async {
    final sharedPref = await SharedPreferences.getInstance();
    final getSharedPref = sharedPref.getString("allTasks");
    if (getSharedPref != null) {
      setState(() {
        tasks = (jsonDecode(getSharedPref) as List)
            .map((e) => TaskModel.fromJson(e))
            .toList();
      });
    }
    print("tasks");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        width: 167,
        child: TasksDoneButton(
          label: "Add New Task",
          function: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          ),
          icon: Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset("images/person.png"),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening ,$username",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFCFC),
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        "One task at a time.One steps\ncloser.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFC6C6C6),
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Color(0xFF282828),
                  child: SizedBox(
                    height: 34,
                    width: 34,
                    child: IconButton(
                      color: Color(0xFF282828),
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "images/Icon-light.svg",
                        colorFilter: ColorFilter.mode(
                          Color(0xFFFFFCFC),
                          BlendMode.srcIn,
                        ),
                        height: 18,
                        width: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Text(
                        "No Tasks Founded",
                        style: TextStyle(
                          fontSize: 32,
                          color: Color(0xFFFFFCFC),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            "Yuhuu ,Your work Is ",
                            style: TextStyle(
                              fontSize: 32,
                              color: Color(0xFFFFFCFC),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            // high row
                            children: [
                              Text(
                                "almost done ! ",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Color(0xFFFFFCFC),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SvgPicture.asset(
                                "images/waving-hand.svg",
                                height: 28,
                                width: 28,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          HighPriority(onTap: (value, index) {}),
                          SizedBox(height: 24),

                          Text(
                            "My Tasks",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFFCFC),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 16),
                          TasksList(
                            tasks: tasks,
                            onTap: (isDone, index) async {
                              setState(() {
                                tasks[index].isDone = isDone!;
                              });
                              final sharedPref =
                                  await SharedPreferences.getInstance();
                              final updateTasks = tasks
                                  .map((e) => e.toJson())
                                  .toList();
                              await sharedPref.setString(
                                "allTasks",
                                jsonEncode(updateTasks),
                              );
                            },
                          ),

                          SizedBox(height: 80),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
