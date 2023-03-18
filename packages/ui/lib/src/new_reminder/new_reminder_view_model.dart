import 'package:ui/src/common/index.dart';

import 'widgets/selected_list_view_model.dart';

abstract class NewReminderViewModel extends ViewModel {
  const NewReminderViewModel();

  TextFieldViewModel get title;

  TextFieldViewModel get subTitle;

  SelectedListViewModel get selectedListViewModel;

  bool get isAddEnabled;

  void onAddPressed();

  void onDetailsPressed();

  void onListPressed();
}
