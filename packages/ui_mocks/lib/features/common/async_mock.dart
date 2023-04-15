import 'dart:ui';

import 'package:doit_ui_mocks/features/common/fixtures.dart' as fixtures;
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

const noData = Object();

class AsyncMock<T> extends Async<T> {
  const AsyncMock._({
    Object? data = noData,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  }) : _data = data;

  const AsyncMock.result(T data) : this._(data: data);

  const AsyncMock.error(UiMessage error, {VoidCallback? onRetry})
      : this._(errorMessage: error, onRetry: onRetry);

  const AsyncMock.errorWithRetry(UiMessage error, {VoidCallback? onRetry = fixtures.onRetry})
      : this._(errorMessage: error, onRetry: onRetry);

  const AsyncMock.loading() : this._(isLoading: true);

  final Object? _data;

  @override
  T? get data => _data == noData ? null : _data as T?;

  @override
  final UiMessage? errorMessage;

  final VoidCallback? onRetry;

  @override
  final bool isLoading;

  @override
  Async<R> map<R>(R Function(T data) transform) {
    if (_data != noData) return AsyncMock.result(transform(data as T));
    if (errorMessage != null) return AsyncMock.error(errorMessage!, onRetry: onRetry);
    if (isLoading) return const AsyncMock.loading();
    throw ArgumentError('Unknown type $runtimeType');
  }

  @override
  R when<R>({
    required R Function(T data) loaded,
    required R Function(UiMessage errorMessage, VoidCallback? onRetry) error,
    required R Function() loading,
  }) {
    final object = this;
    if (_data != noData) return loaded(data as T);
    if (errorMessage != null) return error(errorMessage!, object.onRetry);
    if (isLoading) return loading();
    throw ArgumentError('Unknown type $runtimeType');
  }
}
