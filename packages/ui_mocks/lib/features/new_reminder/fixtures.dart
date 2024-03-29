import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:doit_ui_mocks/features/new_reminder/new_reminder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'selected_list_view_model.dart';

final newReminderPages = <String, WidgetBuilder>{
  '/new-reminder/initial': (_) => const NewReminderPage(
        viewModel:
            NewReminderViewModelMock(selectedListViewModel: SelectedListViewModelMock.loading()),
      ),
  '/new-reminder/error': (_) => const NewReminderPage(
        viewModel: NewReminderViewModelMock(
          selectedListViewModel: SelectedListViewModelMock.error(),
        ),
      ),
  '/new-reminder/filled': (_) => const NewReminderPage(
        viewModel: NewReminderViewModelMock(
          selectedListViewModel: SelectedListViewModelMock.loaded(),
          title: TextFieldViewModelMock(value: 'New first task'),
          subTitle: TextFieldViewModelMock(
            value: 'Finish the home screen and generate the golden tests for it',
          ),
          isAddEnabled: true,
        ),
      ),
};
