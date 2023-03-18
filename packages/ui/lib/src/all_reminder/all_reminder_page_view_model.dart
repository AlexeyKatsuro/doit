import '../common/view_model.dart';
import 'task_list_view_model.dart';

abstract class AllReminderPageViewModel extends ViewModel {
  const AllReminderPageViewModel();

  List<TaskListViewModel> get lists;
}
