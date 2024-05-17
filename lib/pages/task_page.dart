import 'package:flutter/material.dart';
import 'package:my_todo_app_isar/components/my_task_tile.dart';
import 'package:my_todo_app_isar/database/task_database.dart';
import 'package:my_todo_app_isar/models/task.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    Provider.of<TaskDatabase>(context, listen: false).fetchTasks();
    super.initState();
  }

  // text controller for taskName
  final TextEditingController taskNameController = TextEditingController();
  // text controller for taskNote
  final TextEditingController taskNoteController = TextEditingController();

  // create a task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task...'),
        content: SizedBox(
          width: 300,
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: taskNameController,
                decoration: const InputDecoration(
                  hintText: 'enter the task name...',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: taskNoteController,
                decoration: const InputDecoration(
                  hintText: 'enter the task description...',
                ),
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              // close dialog box without savig
              Navigator.pop(context);

              // clear taskName controller
              taskNameController.clear();
              // clear taskNote controller
              taskNoteController.clear();
            },
            child: const Text('cancel'),
          ),
          MaterialButton(
            onPressed: () {
              // get the new task name
              String newTaskName = taskNameController.text;
              String newTaskNote = taskNoteController.text;

              // save to task db
              context.read<TaskDatabase>().addTask(newTaskName, newTaskNote);

              // pop (close) dialog box
              Navigator.pop(context);

              // clear taskName controller
              taskNameController.clear();
              // clear taskNote controller
              taskNoteController.clear();
            },
            child: const Text('save'),
          ),
        ],
      ),
    );
  }

  // read a task
  void showTasks() {
    context.watch<TaskDatabase>().fetchTasks();
  }

  // update / edit task
  void editTask(Task task) {
    // prefill taskName for task to edit
    taskNameController.text = task.taskName;
    // prefill taskNote for task to edit
    taskNoteController.text = task.taskNote;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Task...'),
        content: SizedBox(
          width: 300,
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: taskNameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: taskNoteController,
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              // close dialog box without savig
              Navigator.pop(context);

              // clear taskName controller
              taskNameController.clear();
              // clear taskNote controller
              taskNoteController.clear();
            },
            child: const Text('cancel'),
          ),
          MaterialButton(
            onPressed: () {
              // save to task db
              context.read<TaskDatabase>().updateTask(
                    task.id,
                    taskNameController.text,
                    taskNoteController.text,
                  );

              // pop (close) dialog box
              Navigator.pop(context);

              // clear taskName controller
              taskNameController.clear();
              // clear taskNote controller
              taskNoteController.clear();
            },
            child: const Text('update'),
          ),
        ],
      ),
    );
  }

  // delete task
  void deleteTask(int id) {
    context.read<TaskDatabase>().deleteTask(id);
  }

  // toggle checkBox
  void toggleCheckBox(bool value, int id) {
    context.read<TaskDatabase>().updateCheckBox(id, value);
  }

  @override
  Widget build(BuildContext context) {
    // task database
    final taskDatabase = context.watch<TaskDatabase>();

    // list of all tasks
    List<Task> taskList = taskDatabase.taskList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // LIST OF TASKS
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                // get individual task
                final task = taskList[index];

                // ListTile to display tasks
                return MyTaskTile(
                  task: task,
                  deleteFunction: () => deleteTask(task.id),
                  editFunction: () => editTask(task),
                  isComplete: true,
                  onChanged: (value) =>
                      toggleCheckBox(task.isComplete, task.id),
                );
              },
            ),
          ),
        ],
      ),

      // FAB to add new task
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
