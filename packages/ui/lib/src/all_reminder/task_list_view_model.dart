import 'package:ui/src/all_reminder/task_view_model.dart';
import 'package:ui/src/common/index.dart';

abstract class TaskListViewModel extends ViewModel {
  const TaskListViewModel();

  String get name;

  List<TaskViewModel> get tasks;
}
