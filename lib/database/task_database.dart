import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:my_todo_app_isar/models/task.dart';
import 'package:path_provider/path_provider.dart';

class TaskDatabase extends ChangeNotifier {
  // initialize database - set-up

  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskSchema],
      directory: dir.path,
    );
  }

  // list of tasks
  final List<Task> taskList = [];

  // CREATE a task and save to db

  Future<void> addTask(String taskName, String taskNote) async {
    // create new task
    final newTask = Task()
      ..taskName = taskName
      ..taskNote = taskNote
      ..isComplete = false;

    // save newTask to db
    await isar.writeTxn(() => isar.tasks.put(newTask));

    // re-read from db
    fetchTasks();
  }

  // READ a task from db
  Future<void> fetchTasks() async {
    List<Task> fetchedTasks = await isar.tasks.where().findAll();

    // clear tasks
    taskList.clear();
    taskList.addAll(fetchedTasks);

    notifyListeners();
  }

  // UPDATE or change a task and save to db
  Future<void> updateTask(
      int id, String newTaskName, String newTaskNote) async {
    // get the task from
    final task = await isar.tasks.get(id);

    if (task != null) {
      await isar.writeTxn(() async {
        // newTaskName assigned to task.taskName
        task.taskName = newTaskName;
        // newTaskNote assigned to task.taskNote
        task.taskNote = newTaskNote;

        // save updated task to db
        await isar.tasks.put(task);
      });

      await fetchTasks();
    }
  }

  // update Check Box
  Future<void> updateCheckBox(int id, bool isComplete) async {
    // find specific task
    final task = await isar.tasks.get(id);

    if (task != null) {
      await isar.writeTxn(() async {
        task.isComplete = !task.isComplete;

        await isar.tasks.put(task);
      });
    }

    notifyListeners();

    await fetchTasks();
  }

  // DELETE a task from db
  Future<void> deleteTask(int id) async {
    // perform delete
    await isar.writeTxn(() async {
      await isar.tasks.delete(id);
    });
    await fetchTasks();
  }
}
