import 'package:doit_ui_mocks/features/common/fixtures.dart';
import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

import 'list_view_model.dart';
import 'select_list_view_model.dart';

final selectListPages = <String, WidgetBuilder>{
  '/select-list/0-loading': (_) => const SelectListPage(viewModel: loading),
  '/select-list/1-error': (_) => const SelectListPage(viewModel: error),
  '/select-list/3-loaded': (_) => const SelectListPage(viewModel: loaded),
};

const loading = SelectListViewModelMock(lists: AsyncMock.loading());

const error = SelectListViewModelMock(
  lists: AsyncMock.errorWithRetry(errorMessage),
);

const loaded = SelectListViewModelMock(
  lists: AsyncMock.result([
    ListViewModelMock(
      name: UiMessage.text(defaultListName),
      icon: IconType.list,
      isSelected: true,
    ),
    ListViewModelMock(
      name: UiMessage.text('Work'),
      icon: IconType.calendar,
      isSelected: false,
    ),
  ]),
);
