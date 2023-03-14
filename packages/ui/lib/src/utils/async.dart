abstract class Async<T> {
  const Async();

  T? get data => null;

  Object? get error => null;

  bool get isLoading => false;

  Async<R> map<R>(
    R Function(T data) transform, {
    Object Function(Object error)? error,
  }) {
    final object = this;
    if (object is AsyncResult<T>) return AsyncResult(transform(object.data));
    if (object is AsyncError) {
      if (error != null) {
        return AsyncError(error(object.error));
      } else {
        return object;
      }
    }
    if (object is AsyncLoading) return object;
    throw ArgumentError('Unknown type $runtimeType');
  }

  R when<R>({
    required R Function(T data) loaded,
    required R Function(Object error) error,
    required R Function() loading,
  }) {
    final object = this;
    if (object is AsyncResult<T>) return loaded(object.data);
    if (object is AsyncError) return error(object.error);
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
  const AsyncError(this.error);

  @override
  final Object error;
}

class AsyncLoading extends Async<Never> {
  const AsyncLoading();
}
