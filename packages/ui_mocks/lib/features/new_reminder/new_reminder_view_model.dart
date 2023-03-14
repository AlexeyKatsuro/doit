import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:ui/ui.dart';

const a = NewReminderViewModelMock();

class NewReminderViewModelMock with MockCallbacks implements NewReminderViewModel {
  const NewReminderViewModelMock({
    this.title = const TextFieldViewModelMock(),
    this.subTitle = const TextFieldViewModelMock(),
    this.selectedListName = const AsyncLoading(),
    this.isAddEnabled = false,
  });

  @override
  final TextFieldViewModel title;

  @override
  final TextFieldViewModel subTitle;

  @override
  final Async<String> selectedListName;

  @override
  final bool isAddEnabled;
}
