import 'package:doit_ui_mocks/features/common/fixtures.dart';
import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

import 'list_builder_view_model_page.dart';

final listBuilderPages = <String, WidgetBuilder>{
  '/list-builder/0-loading': (_) => const ListCommonPage(viewModel: loading),
  '/list-builder/1-error': (_) => const ListCommonPage(viewModel: error),
  '/list-builder/2-loaded-idle': (_) => const ListCommonPage(viewModel: loadedIdle),
  '/list-builder/3-loaded-filled': (_) => const ListCommonPage(viewModel: loadedIdle),
  '/list-builder/4-loaded-loading': (_) => const ListCommonPage(viewModel: loadedUploading),
  '/list-builder/5-loaded-error': (_) => const ListCommonPage(viewModel: loadedError),
  '/list-builder/6-loaded-done': (_) => const ListCommonPage(viewModel: loadedDone),
};

const loading = ListBuilderViewModelPageMock(
    title: UiMessage.text('New List'),
    submitStatus: Upload.idle(),
    listNameField: AsyncMock.loading());

const error = ListBuilderViewModelPageMock(
    title: UiMessage.text('New List'),
    submitStatus: Upload.idle(),
    listNameField: AsyncMock.error(errorMessage));

const loadedIdle = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: AsyncMock.result(TextFieldViewModelMock()),
  submitStatus: Upload.idle(),
);

const loadedFiled = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: AsyncMock.result(TextFieldViewModelMock(value: defaultListName)),
  submitStatus: Upload.idle(),
);

const loadedUploading = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: AsyncMock.result(TextFieldViewModelMock(value: defaultListName)),
  submitStatus: Upload.loading(),
);

const loadedError = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: AsyncMock.result(TextFieldViewModelMock(value: defaultListName)),
  submitStatus: Upload.error(errorMessage),
);

const loadedDone = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: AsyncMock.result(TextFieldViewModelMock(value: defaultListName)),
  submitStatus: Upload.done(),
);
