import 'package:doit_ui_mocks/features/all_reminder/task_view_model.dart';
import 'package:doit_ui_mocks/features/common/fixtures.dart';
import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:ui/ui.dart';

class TaskListViewModelMock with MockCallbacks implements TaskListViewModel {
  const TaskListViewModelMock({
    this.name = defaultListName,
    this.tasks = const [
      TaskViewModelMock(),
    ],
  });

  @override
  final String name;

  @override
  final List<TaskViewModel> tasks;
}
