import 'package:localization/localization.dart';
import 'package:ui/src/common/index.dart';

abstract class HomeViewModel {
  const HomeViewModel();

  TextFieldViewModel get search;

  List<DashboardTileViewModel> get dashboard;

  List<TaskListTileViewModel> get lists;

  void onEditListsPressed();

  void onTemplatesPressed();

  void onDashboardListOrderChanged(List<DashboardTileViewModel> ordered);

  void onTaskListOrderChanged(List<TaskListTileViewModel> ordered);

  void onAddReminderPressed();

  void onAddListPressed();

  void onAddGroupPressed();

  bool get isEditMode;
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
