import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:ui/ui.dart';

class NewReminderViewModelMock with MockCallbacks implements NewReminderViewModel {
  const NewReminderViewModelMock({
    this.title = const TextFieldViewModelMock(),
    this.subTitle = const TextFieldViewModelMock(),
    this.selectedListName = 'Reminders',
    this.isAddEnabled = false,
  });

  @override
  final TextFieldViewModel title;

  @override
  final TextFieldViewModel subTitle;

  @override
  final String selectedListName;

  @override
  final bool isAddEnabled;
}
