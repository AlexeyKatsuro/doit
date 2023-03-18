import 'package:localization/localization.dart';
import 'package:ui/src/common/index.dart';

abstract class HomeViewModel extends ViewModel {
  const HomeViewModel();

  TextFieldViewModel get search;

  List<DashboardTileViewModel> get dashboard;

  List<TaskListTileViewModel> get lists;

  bool get isEditMode;

  void onEditListsPressed();

  void onTemplatesPressed();

  void onDashboardListOrderChanged(List<DashboardTileViewModel> ordered);

  void onTaskListOrderChanged(List<TaskListTileViewModel> ordered);

  void onAddReminderPressed();

  void onAddListPressed();

  void onAddGroupPressed();

  void onLogoutPressed();
}

abstract class DashboardTileViewModel {
  const DashboardTileViewModel();

  IconType get icon;

  UiMessage get name;

  int get count;

  bool get selected;

  void onPressed();
}

abstract class TaskListTileViewModel {
  const TaskListTileViewModel();

  IconType get icon;

  UiMessage get name;

  int get count;

  void onPressed();
}
