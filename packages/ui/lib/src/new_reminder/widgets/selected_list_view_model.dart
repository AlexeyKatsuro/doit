import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

abstract class SelectedListViewModel extends ViewModel {
  const SelectedListViewModel();

  Async<UiMessage> get selectedListName;
}
