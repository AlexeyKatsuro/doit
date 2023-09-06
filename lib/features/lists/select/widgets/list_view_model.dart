import 'dart:ui';

import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

class ListViewModelImpl extends ListViewModel {
  ListViewModelImpl({
    required this.icon,
    required this.isSelected,
    required this.name,
    required VoidCallback onPressed,
  }) : _onPressed = onPressed;

  @override
  final IconType icon;

  @override
  final bool isSelected;

  @override
  final UiMessage name;

  final VoidCallback _onPressed;

  @override
  void onPressed() => _onPressed();
}
