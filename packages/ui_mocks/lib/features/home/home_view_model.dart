import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

class HomeViewModelMock extends HomeViewModel with MockCallbacks {
  HomeViewModelMock({
    this.dashboard = const [],
    this.isEditMode = false,
    this.lists = const [],
    this.search = const TextFieldViewModelMock(),
  });

  @override
  final TextFieldViewModel search;

  @override
  final List<DashboardTileViewModel> dashboard;

  @override
  final bool isEditMode;

  @override
  final List<TaskListTileViewModel> lists;
}

class DashboardTileViewModelMock extends DashboardTileViewModel with MockCallbacks {
  const DashboardTileViewModelMock({
    this.count = 0,
    this.icon = IconType.schedule,
    this.name = const UiMessage.text('Today'),
    this.selected = true,
  });

  @override
  final int count;

  @override
  final IconType icon;

  @override
  final UiMessage name;

  @override
  final bool selected;
}

class TaskListTileViewModelMock extends TaskListTileViewModel with MockCallbacks {
  const TaskListTileViewModelMock({
    this.count = 0,
    this.icon = IconType.list,
    this.name = const UiMessage.text('Reminders'),
  });

  @override
  final int count;

  @override
  final IconType icon;

  @override
  final UiMessage name;
}
