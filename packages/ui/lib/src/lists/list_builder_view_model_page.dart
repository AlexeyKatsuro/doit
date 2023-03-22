import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

abstract class ListBuilderViewModelPage {
  const ListBuilderViewModelPage();

  UiMessage get title;

  Async<TextFieldViewModel> get listNameField;

  bool get isSubmitEnabled {
    bool notEnabled([_]) => false;

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
