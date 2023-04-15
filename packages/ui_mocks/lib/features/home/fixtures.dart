import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

import 'home_view_model.dart';

final homePages = <String, WidgetBuilder>{
  '/home/loaded': (_) => HomePage(viewModel: loadedHomeViewModel),
};

final loadedHomeViewModel = HomeViewModelMock(
  dashboard: const AsyncMock.result(dashboardList),
  lists: const AsyncMock.result(lists),
);

const dashboardList = [
  DashboardTileViewModelMock(
    icon: IconType.calendar,
    name: UiMessage.text('Today'),
    count: 2,
  ),
  DashboardTileViewModelMock(
    icon: IconType.archive,
    name: UiMessage.text('All'),
    count: 5,
  ),
  DashboardTileViewModelMock(
    icon: IconType.schedule,
    name: UiMessage.text('Scheduled'),
    count: 2,
  ),
  DashboardTileViewModelMock(
    icon: IconType.flag,
    name: UiMessage.text('Flagged'),
    count: 0,
  ),
  DashboardTileViewModelMock(
    icon: IconType.check,
    name: UiMessage.text('Completed'),
    count: 0,
  ),
];

const lists = [
  TaskListTileViewModelMock(),
];
