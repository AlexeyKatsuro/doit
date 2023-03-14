import 'package:localization/localization.dart';

abstract class SelectedListViewModel {
  R when<R>({
    required R Function(SelectedListLoadedViewModel vm) loaded,
    required R Function(SelectedListErrorViewModel vm) error,
    required R Function(SelectedListLoadingViewModel vm) loading,
  });
}

abstract class SelectedListLoadedViewModel {
  UiMessage get selectedListName;

  void onPressed();
}

abstract class SelectedListErrorViewModel {
  UiMessage get errorMessage;

  void onRetry();
}

abstract class SelectedListLoadingViewModel {}
