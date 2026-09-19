// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_application_4/widgets/tasks_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighPriority extends StatefulWidget {
  HighPriority({super.key, required this.onTap});

  Function(bool? value, int index) onTap;
  @override
  State<HighPriority> createState() => _HighPriorityState();
}

class _HighPriorityState extends State<HighPriority> {
  List<TaskModel> priorityTask = [];

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
        priorityTask = (jsonDecode(getSharedPref) as List)
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isHighPriority == true)
            .toList();
      });
    }
    print("tasks");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF282828),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "High Priority Tasks",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF15B86C),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: priorityTask.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF282828),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,

                      activeColor: Color(0xFF15B86C),
                      value: priorityTask[index].isDone,
                      onChanged: (value) {},
                    ),
                    Expanded(
                      child: Text(
                        priorityTask[index].taskName,
                        style: TextStyle(
                          fontSize: 16,
                          color: priorityTask[index].isDone
                              ? Color(0xFFA0A0A0)
                              : Color(0xFFFFFCFC),
                          fontWeight: FontWeight.w400,
                          decoration: priorityTask[index].isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: Color(0xFFA0A0A0),
                          decorationThickness: 1.5,
                        ),

                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert_outlined,
                        color: priorityTask[index].isDone
                            ? Color(0xFFA0A0A0)
                            : Color(0xFFC6C6C6),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 0);
            },
          ),
        ],
      ),
    );
  }
}
