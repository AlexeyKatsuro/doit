import 'package:ui/ui.dart';

import 'task_list_view_model.dart';

class AllReminderPageViewModelMock extends AllReminderPageViewModel {
  const AllReminderPageViewModelMock({
    this.lists = const [
      TaskListViewModelMock(),
    ],
  });

  @override
  final List<TaskListViewModel> lists;
}
