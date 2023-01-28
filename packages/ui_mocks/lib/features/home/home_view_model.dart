import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:flutter/foundation.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

class HomeViewModelMock extends HomeViewModel with MockCallbacks {
  HomeViewModelMock({
    List<DashboardTileViewModel>? dashboard,
    bool? isEditMode,
    List<TaskListTileViewModel>? lists,
    TextFieldViewModel? search,
  })  : dashboard = dashboard ??
            [
              const DashboardTileViewModelMock(
                icon: IconType.calendar,
                name: UiMessage.text('Today'),
                count: 2,
              ),
              const DashboardTileViewModelMock(
                icon: IconType.archive,
                name: UiMessage.text('All'),
                count: 5,
              ),
              const DashboardTileViewModelMock(
                icon: IconType.schedule,
                name: UiMessage.text('Scheduled'),
                count: 2,
              ),
              const DashboardTileViewModelMock(
                icon: IconType.flag,
                name: UiMessage.text('Flagged'),
                count: 0,
              ),
              const DashboardTileViewModelMock(
                icon: IconType.check,
                name: UiMessage.text('Completed'),
                count: 0,
              ),
            ],
        isEditMode = isEditMode ?? false,
        lists = lists ??
            [
              const TaskListTileViewModelMock(),
            ],
        search = search ?? TextFieldViewModelMock();

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
    int? count,
    IconType? icon,
    UiMessage? name,
    bool? selected,
  })  : count = count ?? 0,
        icon = icon ?? IconType.schedule,
        name = name ?? const UiMessage.text('Today'),
        selected = selected ?? true;

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
    int? count,
    IconType? icon,
    UiMessage? name,
    bool? selected,
  })  : count = count ?? 0,
        icon = icon ?? IconType.list,
        name = name ?? const UiMessage.text('Reminders');

  @override
  final int count;

  @override
  final IconType icon;

  @override
  final UiMessage name;

}
