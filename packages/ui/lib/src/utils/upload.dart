import 'package:localization/localization.dart';

abstract class Upload {
  const Upload();

  const factory Upload.idle() = UploadIdle;

  const factory Upload.done() = UploadDone;

  const factory Upload.error(UiMessage error) = UploadError;

  const factory Upload.loading() = UploadLoading;

  R when<R>({
    required R Function() idle,
    required R Function() loaded,
    required R Function(Object error) error,
    required R Function() loading,
  }) {
    final object = this;
    if (object is UploadIdle) return loaded();
    if (object is UploadDone) return loaded();
    if (object is UploadError) return error(object.error);
    if (object is UploadLoading) return loading();
    throw ArgumentError('Unknown type $runtimeType');
  }

  R whenOrElse<R>({
    R Function()? idle,
    R Function()? loaded,
    R Function(Object error)? error,
    R Function()? loading,
    required R Function() orElse,
  }) {
    return when(
      idle: idle ?? orElse,
      loaded: loaded ?? orElse,
      error: error ?? (error) => orElse(),
      loading: loading ?? orElse,
    );
  }

  UiMessage? get errorMessage {
    final object = this;
    if (object is UploadError) return object.error;
    return null;
  }

  bool get isLoading => this is UploadLoading;

  bool get isIdle => this is UploadIdle;

  bool get isDone => this is UploadDone;
}

class UploadIdle extends Upload {
  const UploadIdle();
}

class UploadDone extends Upload {
  const UploadDone();
}

class UploadError extends Upload {
  const UploadError(this.error);

  final UiMessage error;
}

class UploadLoading extends Upload {
  const UploadLoading();
}
