import 'dart:ui';

import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

abstract class AsyncMock<T> extends Async<T> {
  const AsyncMock();

  const factory AsyncMock.result(T data) = AsyncResult<T>;

  const factory AsyncMock.error(UiMessage error) = AsyncError;

  const factory AsyncMock.loading() = AsyncLoading;

  @override
  T? get data => null;

  @override
  UiMessage? get errorMessage => null;

  @override
  bool get isLoading => false;

  @override
  Async<R> map<R>(R Function(T data) transform) {
    final object = this;
    if (object is AsyncResult<T>) return AsyncResult(transform(object.data));
    if (object is AsyncError) return object;
    if (object is AsyncLoading) return object;
    throw ArgumentError('Unknown type $runtimeType');
  }

  @override
  R when<R>({
    required R Function(T data) loaded,
    required R Function(UiMessage errorMessage, VoidCallback? onRetry) error,
    required R Function() loading,
  }) {
    final object = this;
    if (object is AsyncResult<T>) return loaded(object.data);
    if (object is AsyncError) return error(object.errorMessage, object.onRetry);
    if (object is AsyncLoading) return loading();
    throw ArgumentError('Unknown type $runtimeType');
  }
}

class AsyncResult<T> extends AsyncMock<T> {
  const AsyncResult(this.data);

  @override
  final T data;
}

class AsyncError extends AsyncMock<Never> {
  const AsyncError(
    this.errorMessage, {
    this.onRetry,
  });

  @override
  final UiMessage errorMessage;
  final VoidCallback? onRetry;
}

class AsyncLoading extends AsyncMock<Never> {
  const AsyncLoading();
}
