import 'package:flutter/material.dart';

import 'app_button_toggleable_styles.dart';

class AppButtonToggleable extends ButtonStyleButton {
  AppButtonToggleable({
    super.key,
    required this.checked,
    required this.onChanged,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
    required Widget child,
  }) : super(
          onPressed: onChanged != null ? () => onChanged(!checked) : null,
          onLongPress: null,
          child: DefaultTextStyle.merge(child: child, textAlign: TextAlign.center),
        );

  static Widget radio<T>({
    Key? key,
    required Widget child,
    ButtonStyle? style,
    required T? groupValue,
    required T value,
    ValueChanged<T?>? onChanged,
    bool toggleable = false,
  }) {
    final checked = value == groupValue;
    void handleTap(bool _) {
      if (onChanged == null) return;
      if (toggleable && checked) {
        onChanged(null);
        return;
      }
      if (!checked) {
        onChanged(value);
      }
    }

    return AppButtonToggleable(
      key: key,
      checked: checked,
      onChanged: onChanged != null ? handleTap : null,
      style: style,
      child: child,
    );
  }

  final ValueChanged<bool>? onChanged;
  final bool checked;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    if (checked) return AppButtonToggleableStyles.defaultCheckedStyle(context);
    return AppButtonToggleableStyles.defaultStyle(context);
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return null;
  }
}
