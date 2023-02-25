import 'package:ui/src/all_reminder/task_view_model.dart';

abstract class TaskListViewModel {
  String get name;

  List<TaskViewModel> get tasks;
}
