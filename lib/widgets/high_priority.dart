// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/task_model.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return priorityTask.isEmpty
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4,
                  ),
                  child: Text(
                    "High Priority Tasks",
                    style: TextStyle(color: Color(0xFF15B86C), fontSize: 14),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: Text(
                    "No priority tasks exist",
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          )
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4,
                  ),
                  child: Text(
                    "High Priority Tasks",
                    style: TextStyle(color: Color(0xFF15B86C), fontSize: 14),
                  ),
                ),
                SizedBox(height: 4),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: priorityTask.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          activeColor: const Color(0xFF15B86C),
                          value: priorityTask[index].isDone,
                          onChanged: (value) {
                            setState(() {
                              priorityTask[index].isDone = value ?? false;
                            });
                          },
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            priorityTask[index].taskName,
                            style: TextStyle(
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
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 4);
                  },
                ),
                SizedBox(height: 4),
              ],
            ),
          );
  }
}
