import 'package:ui/src/common/index.dart';

abstract class NewReminderViewModel {
  TextFieldViewModel get title;

  TextFieldViewModel get subTitle;

  String get selectedListName;

  bool get isAddEnabled;

  void onAddPressed();

  void onDetailsPressed();

  void onListPressed();
}
