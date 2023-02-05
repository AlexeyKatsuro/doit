import 'package:flutter/material.dart';

/// Custom wrapper over material [IconButton] for future extension
class AppButtonIcon extends IconButton {
  const AppButtonIcon({
    super.key,
    super.iconSize,
    super.visualDensity,
    super.padding,
    super.alignment,
    double? splashRadius,
    super.color,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.disabledColor,
    VoidCallback? onPressed,
    super.mouseCursor,
    super.focusNode,
    super.autofocus,
    super.tooltip,
    super.enableFeedback,
    super.constraints,
    super.style,
    super.isSelected,
    super.selectedIcon,
    required super.icon,
    bool? enable,
  }) : super(splashRadius: splashRadius ?? 24, onPressed: (enable ?? true) ? onPressed : null);
}
