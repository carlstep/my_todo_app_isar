import 'package:isar/isar.dart';

// this line is needed to generate the isar file
// run this code: dart run build_runner build

part 'task.g.dart';

@Collection()
class Task {
  // task id - created by isar
  Id id = Isar.autoIncrement;

  // task name
  late String taskName;

  late String taskNote;

  // is task complete
  bool? isComplete;
}
