import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';
import 'package:ui/src/common/index.dart';

abstract class SelectedListViewModel extends ViewModel {
  const SelectedListViewModel();

  @protected
  Object get state;

  R when<R>({
    required R Function(SelectedListLoadedViewModel vm) loaded,
    required R Function(SelectedListErrorViewModel vm) error,
    required R Function(SelectedListLoadingViewModel vm) loading,
  }) {
    final stage = state;
    if (stage is SelectedListLoadedViewModel) return loaded(stage);
    if (stage is SelectedListErrorViewModel) return error(stage);
    if (stage is SelectedListLoadingViewModel) return loading(stage);
    throw ArgumentError.value(stage, 'Unknown type ${stage.runtimeType}');
  }

  bool get isLoaded => state is SelectedListLoadedViewModel;

  SelectedListLoadedViewModel get asLoaded {
    final stage = state;
    if (stage is SelectedListLoadedViewModel) {
      return stage;
    } else {
      throw ArgumentError.value(stage, 'is not $SelectedListLoadedViewModel');
    }
  }
}

abstract class SelectedListLoadedViewModel extends ViewModel {
  const SelectedListLoadedViewModel();

  UiMessage get selectedListName;

  void onPressed();
}

abstract class SelectedListErrorViewModel extends ViewModel {
  const SelectedListErrorViewModel();

  UiMessage get errorMessage;

  void onRetry();
}

class SelectedListLoadingViewModel extends ViewModel {
  const SelectedListLoadingViewModel();
}
