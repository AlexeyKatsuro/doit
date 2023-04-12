import 'dart:ui';

import 'package:doit/features/common/index.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

mixin RunAsync on ViewModel, Store {
  UiMessage localizeError(Object error) => error.toUiMessage();

  Async<T> runAsync<T>(
    Future<T> Function() invocation, {
    Future<T> Function()? retry,
    UiMessage Function(Object)? localizeError,
    String? name,
  }) {
    return AsyncImpl.invocation(
      invocation: invocation,
      retryInvocation: retry,
      localizeError: localizeError ?? this.localizeError,
      context: context,
      name: name,
    );
  }

  Async<T> completeAsync<T>(
    T result, {
    String? name,
  }) {
    return AsyncImpl.completed(
      result: result,
      localizeError: localizeError,
      context: context,
      name: name,
    );
  }
}

class AsyncImpl<T> extends Async<T> {
  AsyncImpl._({
    required AsyncResult<T> result,
    required this.localizeError,
    VoidCallback? retryInvocation,
  })  : _result = result,
        _retryInvocation = retryInvocation;

  AsyncImpl.invocation({
    required Future<T> Function() invocation,
    required this.localizeError,
    VoidCallback? retryInvocation,
    ReactiveContext? context,
    String? name,
  })  : _result = AsyncResult.fromFuture(invocation(), context: context, name: name),
        _retryInvocation = retryInvocation ?? invocation;

  AsyncImpl.completed({
    required T result,
    required this.localizeError,
    ReactiveContext? context,
    String? name,
  })  : _result = AsyncResult.loaded(result, context: context, name: name),
        _retryInvocation = null;

  /*static AsyncImpl<R> transform<P, R>({
    required AsyncImpl<P> parent,
    required R Function(P data) transform,
    ReactiveContext? context,
    String? name,
  }) {
    return AsyncImpl<R>._(
      result: AsyncResult.fromMap(parent._result, transform: transform),
      retryInvocation: parent._retryInvocation,
      localizeError: parent.localizeError,
    );
  }*/

  final AsyncResult<T> _result;
  final VoidCallback? _retryInvocation;
  final UiMessage Function(Object) localizeError;

  @override
  Async<R> map<R>(R Function(T data) transform) {
    return AsyncImpl<R>._(
      result: AsyncResultDelegate<T, R>(_result, transform),
      localizeError: localizeError,
      retryInvocation: _retryInvocation,
    );
  }

  @override
  R when<R>({
    required R Function(T data) loaded,
    required R Function(UiMessage errorMessage, VoidCallback? onRetry) error,
    required R Function() loading,
  }) {
    switch (_result.status) {
      case AsyncStatus.loaded:
        return loaded(_result.result);
      case AsyncStatus.failure:
        return error(localizeError(_result.failure), _retryInvocation);
      case AsyncStatus.loading:
        return loading();
    }
  }
}

enum AsyncStatus { loading, failure, loaded }

class AsyncResult<T> {
  AsyncResult._({
    required AsyncStatus status,
    required Object? result,
    ReactiveContext? context,
    String? name,
  })  : _axnController = ActionController(context: context, name: '$name.ActionController'),
        _status = Observable(status, name: '$name.status'),
        _result = Observable(result, name: '$name.result');

  AsyncResult.loading({
    ReactiveContext? context,
    String? name,
  }) : this._(result: null, status: AsyncStatus.loading);

  AsyncResult.loaded(
    T result, {
    ReactiveContext? context,
    String? name,
  }) : this._(result: result, status: AsyncStatus.loaded);

  AsyncResult.failure(
    Object result, {
    ReactiveContext? context,
    String? name,
  }) : this._(result: result, status: AsyncStatus.failure);

  static AsyncResult<T> fromFuture<T>(
    Future<T> future, {
    ReactiveContext? context,
    String? name,
  }) {
    final async = AsyncResult<T>.loading(context: context, name: name);
    future.then(async._fulfill, onError: async._reject);
    return async;
  }

  /*static AsyncResult<R> fromMap<P, R>(
    AsyncResult<P> parentAsync, {
    ReactiveContext? context,
    required R Function(P data) transform,
    String? name,
  }) {
    final result = AsyncResult<R>.loading(context: context, name: name);
    autorun(
      (_) {
        switch (parentAsync.status) {
          case AsyncStatus.loaded:
            result._fulfill(transform(parentAsync.result));
            break;
          case AsyncStatus.failure:
            result._reject(parentAsync.failure);
            break;
          case AsyncStatus.loading:
            result._load();
            break;
        }
      },
      context: context,
    );
    return result;
  }*/

  final ActionController _axnController;

  final Observable<AsyncStatus> _status;

  AsyncStatus get status => _status.value;

  final Observable<Object?> _result;

  T get result => _result.value as T;

  Object get failure => _result.value as Object;

  void _fulfill(T value) {
    final prevDerivation = _axnController.startAction();
    try {
      _status.value = AsyncStatus.loaded;
      _result.value = value;
    } finally {
      _axnController.endAction(prevDerivation);
    }
  }

  void _reject(dynamic error) {
    final prevDerivation = _axnController.startAction();
    try {
      _status.value = AsyncStatus.failure;
      _result.value = error;
    } finally {
      _axnController.endAction(prevDerivation);
    }
  }
}

class AsyncResultDelegate<P, R> implements AsyncResult<R> {
  AsyncResultDelegate(this.delegate, this.transform);

  final AsyncResult<P> delegate;
  final R Function(P) transform;

  @override
  ActionController get _axnController => throw UnimplementedError();

  @override
  void _fulfill(R value) {
    throw UnimplementedError('_fulfill is invalid method');
  }

  @override
  void _reject(error) {
    throw UnimplementedError('_reject is invalid method');
  }

  @override
  Observable<Object?> get _result => delegate._result;

  @override
  Observable<AsyncStatus> get _status => delegate._status;

  @override
  Object get failure => delegate.failure;

  @override
  R get result => transform(delegate._result.value as P);

  @override
  AsyncStatus get status => delegate.status;
}
