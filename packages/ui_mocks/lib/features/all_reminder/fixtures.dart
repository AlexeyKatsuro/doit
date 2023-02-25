import 'package:doit_ui_mocks/features/all_reminder/task_list_view_model.dart';
import 'package:doit_ui_mocks/features/all_reminder/task_view_model.dart';
import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

import 'all_reminder_page_view_model.dart';

final allReminderPages = <String, WidgetBuilder>{
  '/all-reminder/initial': (_) => const AllReminderPage(viewModel: AllReminderPageViewModelMock()),
  '/all-reminder/filled-completed': (_) => const AllReminderPage(
        viewModel: AllReminderPageViewModelMock(lists: [
          TaskListViewModelMock(name: 'Production', tasks: [
            TaskViewModelMock(
              isCompleted: true,
              title: TextFieldViewModelMock(value: 'New first task'),
              subTitle: TextFieldViewModelMock(
                value: 'Finish the all reminder screen and generate the golden tests for it',
              ),
            )
          ]),
          TaskListViewModelMock(name: 'Reminders', tasks: [
            TaskViewModelMock(
              isCompleted: false,
              title: TextFieldViewModelMock(value: 'New second task'),
            )
          ]),
        ]),
      ),
};
