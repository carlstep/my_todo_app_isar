// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:my_todo_app_isar/models/task.dart';

class MyTaskTile extends StatelessWidget {
  final Task task;
  final void Function()? deleteFunction;
  final void Function()? editFunction;

  const MyTaskTile({
    Key? key,
    required this.task,
    required this.deleteFunction,
    required this.editFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        title: Text(task.taskName),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: editFunction,
              icon: Icon(Icons.settings),
            ),
            IconButton(
              onPressed: deleteFunction,
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
