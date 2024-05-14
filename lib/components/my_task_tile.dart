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
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // taskName - settings for displaying task name
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    task.taskName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 20,
                    ),
                  ),
                  const Checkbox(value: false, onChanged: null),
                ],
              ),
            ),
            // taskNote - settings for displaying task description
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 0, right: 10),
              child: Row(
                children: [
                  Text(task.taskNote),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: editFunction,
                  icon: const Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: deleteFunction,
                  icon: const Icon(Icons.delete),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
