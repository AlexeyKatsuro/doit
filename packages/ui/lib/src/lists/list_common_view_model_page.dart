import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

abstract class NewListPageViewModel extends ListCommonPageViewModel {}

abstract class EditListPageViewModel extends ListCommonPageViewModel {}

abstract class ListCommonPageViewModel extends ViewModel {
  const ListCommonPageViewModel();

  UiMessage get title;

  Async<TextFieldViewModel> get listNameField;

  bool get isSubmitEnabled {
    bool notEnabled([_, __]) => false;

    return listNameField.when(
      loaded: (data) {
        return data.isNotEmpty && !submitStatus.isLoading;
      },
      error: notEnabled,
      loading: notEnabled,
    );
  }

  Upload get submitStatus;

  void onSubmitPressed();
}
