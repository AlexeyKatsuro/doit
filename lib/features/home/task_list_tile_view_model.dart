import 'dart:ui';

import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

class TaskListTileViewModelImpl extends TaskListTileViewModel {
  TaskListTileViewModelImpl({
    required this.count,
    required this.icon,
    required this.name,
    required VoidCallback onPressed,
  }) : _onPressed = onPressed;

  @override
  final int count;

  @override
  final IconType icon;

  @override
  final UiMessage name;

  final VoidCallback _onPressed;

  @override
  void onPressed() => _onPressed();
}
