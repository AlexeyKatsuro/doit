import 'package:localization/localization.dart';
import 'package:ui/src/common/index.dart';

abstract class ListViewModel extends ViewModel {
  const ListViewModel();

  IconType get icon;

  UiMessage get name;

  bool get isSelected;

  void onPressed();
}
