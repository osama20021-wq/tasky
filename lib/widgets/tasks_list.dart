// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/task_model.dart';

class TasksList extends StatelessWidget {
  TasksList({super.key, required this.tasks, required this.onTap});
  List<TaskModel> tasks = [];
  Function(bool? isDone, int index) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFF282828),
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(width: 4),
              Checkbox(
                activeColor: Color(0xFF15B86C),
                value: tasks[index].isDone,
                onChanged: (value) async => await onTap(value, index),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tasks[index].taskName,
                      style: TextStyle(
                        fontSize: 16,
                        color: tasks[index].isDone
                            ? Color(0xFFA0A0A0)
                            : Color(0xFFFFFCFC),
                        fontWeight: FontWeight.w400,
                        decoration: tasks[index].isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Color(0xFFA0A0A0),
                        decorationThickness: 1.5,
                      ),

                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    if (tasks[index].isDone == false)
                      Text(
                        tasks[index].taskDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFC6C6C6),
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: tasks[index].isDone
                      ? Color(0xFFA0A0A0)
                      : Color(0xFFC6C6C6),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 8);
      },
    );
  }
}
