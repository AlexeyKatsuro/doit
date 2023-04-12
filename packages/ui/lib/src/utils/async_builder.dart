import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';

import 'async.dart';

typedef AsyncLoadingBuilder = Widget Function(BuildContext contex);
typedef AsyncErrorBuilder = Widget Function(
    BuildContext context, UiMessage errorMessage, VoidCallback? onRetry);
typedef AsyncLoadedBuilder<T> = Widget Function(BuildContext context, T data);

class AsyncBuilder<T> extends StatelessWidget {
  const AsyncBuilder({
    super.key,
    required this.async,
    required this.loaded,
    AsyncErrorBuilder? error,
    AsyncLoadingBuilder? loading,
  })  : error = error ?? defaultError,
        loading = loading ?? defaultLoading;

  static Widget defaultError(BuildContext context, UiMessage errorMessage, VoidCallback? onRetry) {
    final l10n = context.l10n;
    return AppCardError(
      label: Text(errorMessage.localize(l10n)),
      onPressed: onRetry,
    );
  }

  static Widget defaultLoading(BuildContext context) {
    return const Center(child: AppLoader());
  }

  final Async<T> async;
  final AsyncLoadedBuilder<T> loaded;
  final AsyncErrorBuilder error;
  final AsyncLoadingBuilder loading;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return async.when(
        loaded: (data) => loaded(context, data),
        error: (errorMessage, onRetry) => error(context, errorMessage, onRetry),
        loading: () => loading(context),
      );
    });
  }
}
