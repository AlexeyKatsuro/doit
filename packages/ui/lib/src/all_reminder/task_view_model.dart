import 'package:ui/src/common/index.dart';

abstract class TaskViewModel {
  bool get isCompleted;

  TextFieldViewModel get title;

  TextFieldViewModel get subTitle;

  void onStatusChanged(bool isCompleted);

  void onDetailsPressed();

  void onSave();
}
