// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:my_todo_app_isar/models/task.dart';

class MyTaskTile extends StatefulWidget {
  final Task task;
  final bool isComplete;
  Function(bool?)? onChanged;
  final void Function()? deleteFunction;
  final void Function()? editFunction;

  MyTaskTile({
    super.key,
    required this.task,
    required this.isComplete,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  State<MyTaskTile> createState() => _MyTaskTileState();
}

class _MyTaskTileState extends State<MyTaskTile> {
  // isExpanded = true, tile is expanded
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Card(
        elevation: 0,
        color: widget.task.isComplete
            ? Colors.green.shade200
            : Theme.of(context).colorScheme.primary,
        margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // taskName - settings for displaying task name
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 0, right: 0),
              child: Row(
                children: [
                  Text(
                    widget.task.taskName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: widget.task.isComplete
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 20,
                    ),
                  ),
                  // CheckBox
                  // value = bool value, onChanged allows to switch between true/false
                  Checkbox(
                    activeColor: Colors.green,
                    value: widget.task.isComplete,
                    onChanged: widget.onChanged,
                  ),
                ],
              ),
            ),
            // taskNote - settings for displaying task description
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 0, right: 0),
              child: _isExpanded
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Text(widget.task.taskNote),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('11/06/2024'),
                            const Expanded(
                              child: SizedBox(
                                width: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: widget.editFunction,
                              icon: const Icon(Icons.settings),
                            ),
                            IconButton(
                              onPressed: widget.deleteFunction,
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        )
                      ],
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
