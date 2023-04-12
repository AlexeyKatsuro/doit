import 'dart:ui';

import 'package:localization/localization.dart';

abstract class Async<T> {
  const Async();

  T? get data => null;

  UiMessage? get errorMessage => null;

  bool get isLoading => false;

  Async<R> map<R>(R Function(T data) transform);

  R when<R>({
    required R Function(T data) loaded,
    required R Function(UiMessage errorMessage, VoidCallback? onRetry) error,
    required R Function() loading,
  });

  R? _nullForLoaded<R>(T data) => null;

  R? _nullForError<R>(UiMessage errorMessage, VoidCallback? onRetry) => null;

  R? _nullForLoading<R>() => null;

  R? whenOrNull<R>({
    R Function(T data)? loaded,
    R Function(UiMessage errorMessage, VoidCallback? onRetry)? error,
    R Function()? loading,
  }) {
    return when(
      loaded: loaded ?? _nullForLoaded,
      error: error ?? _nullForError,
      loading: loading ?? _nullForLoading,
    );
  }

  R whenOrElse<R>({
    R Function(T data)? loaded,
    R Function(UiMessage errorMessage, VoidCallback? onRetry)? error,
    R Function()? loading,
    required R Function() orElse,
  }) {
    return whenOrNull<R>(loaded: loaded, error: error, loading: loading) ?? orElse();
  }
}



