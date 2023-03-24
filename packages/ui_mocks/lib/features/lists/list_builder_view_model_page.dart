import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

class ListBuilderViewModelPageMock extends ListCommonPageViewModel with MockCallbacks {
  const ListBuilderViewModelPageMock({
    required this.title,
    required this.listNameField,
    required this.submitStatus,
  });

  @override
  final UiMessage title;

  @override
  final Async<TextFieldViewModel> listNameField;

  @override
  final Upload submitStatus;
}
