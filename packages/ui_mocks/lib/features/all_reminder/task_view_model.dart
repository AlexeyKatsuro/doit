import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:ui/ui.dart';

class TaskViewModelMock with MockCallbacks implements TaskViewModel {
  const TaskViewModelMock({
    this.isCompleted = false,
    this.title = const TextFieldViewModelMock(),
    this.subTitle = const TextFieldViewModelMock(),
  });

  @override
  final bool isCompleted;

  @override
  final TextFieldViewModel title;

  @override
  final TextFieldViewModel subTitle;
}
