import 'package:localization/localization.dart';
import 'package:ui/src/common/icon_view_model.dart';

abstract class ListViewModel {
  const ListViewModel();

  IconType get icon;

  UiMessage get name;

  bool get isSelected;

  void onPressed();
}
