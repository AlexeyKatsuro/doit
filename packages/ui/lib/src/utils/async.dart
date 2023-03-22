import 'package:localization/localization.dart';

abstract class Async<T> {
  const Async();

  const factory Async.result(T data) = AsyncResult<T>;

  const factory Async.error(UiMessage error) = AsyncError;

  const factory Async.loading() = AsyncLoading;

  T? get data => null;

  UiMessage? get errorMessage => null;

  bool get isLoading => false;

  Async<R> map<R>(R Function(T data) transform) {
    final object = this;
    if (object is AsyncResult<T>) return AsyncResult(transform(object.data));
    if (object is AsyncError) return object;
    if (object is AsyncLoading) return object;
    throw ArgumentError('Unknown type $runtimeType');
  }

  R when<R>({
    required R Function(T data) loaded,
    required R Function(UiMessage errorMessage) error,
    required R Function() loading,
  }) {
    final object = this;
    if (object is AsyncResult<T>) return loaded(object.data);
    if (object is AsyncError) return error(object.errorMessage);
    if (object is AsyncLoading) return loading();
    throw ArgumentError('Unknown type $runtimeType');
  }
}

class AsyncResult<T> extends Async<T> {
  const AsyncResult(this.data);

  @override
  final T data;
}

class AsyncError extends Async<Never> {
  const AsyncError(this.errorMessage);

  @override
  final UiMessage errorMessage;
}

class AsyncLoading extends Async<Never> {
  const AsyncLoading();
}
