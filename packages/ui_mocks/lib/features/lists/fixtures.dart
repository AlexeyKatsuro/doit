import 'package:doit_ui_mocks/features/common/fixtures.dart';
import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

import 'list_builder_view_model_page.dart';

final listBuilderPages = <String, WidgetBuilder>{
  '/list-builder/0-loading': (_) => const ListBuilderPage(viewModel: loading),
  '/list-builder/1-error': (_) => const ListBuilderPage(viewModel: error),
  '/list-builder/2-loaded-idle': (_) => const ListBuilderPage(viewModel: loadedIdle),
  '/list-builder/3-loaded-filled': (_) => const ListBuilderPage(viewModel: loadedIdle),
  '/list-builder/4-loaded-loading': (_) => const ListBuilderPage(viewModel: loadedUploading),
  '/list-builder/5-loaded-error': (_) => const ListBuilderPage(viewModel: loadedError),
  '/list-builder/6-loaded-done': (_) => const ListBuilderPage(viewModel: loadedDone),
};

const loading = ListBuilderViewModelPageMock(
    title: UiMessage.text('New List'), submitStatus: Upload.idle(), listNameField: Async.loading());

const error = ListBuilderViewModelPageMock(
    title: UiMessage.text('New List'),
    submitStatus: Upload.idle(),
    listNameField: Async.error(errorMessage));

const loadedIdle = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: Async.result(TextFieldViewModelMock()),
  submitStatus: Upload.idle(),
);

const loadedFiled = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: Async.result(TextFieldViewModelMock(value: defaultListName)),
  submitStatus: Upload.idle(),
);

const loadedUploading = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: Async.result(TextFieldViewModelMock(value: defaultListName)),
  submitStatus: Upload.loading(),
);

const loadedError = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: Async.result(TextFieldViewModelMock(value: defaultListName)),
  submitStatus: Upload.error(errorMessage),
);

const loadedDone = ListBuilderViewModelPageMock(
  title: UiMessage.text('New List'),
  listNameField: Async.result(TextFieldViewModelMock(value: defaultListName)),
  submitStatus: Upload.done(),
);
