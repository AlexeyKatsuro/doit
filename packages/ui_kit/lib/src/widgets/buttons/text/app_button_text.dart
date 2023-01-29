import 'package:flutter/material.dart';
import 'package:ui_kit/src/widgets/loaders/index.dart';

/// Custom wrapper over material button for future extension
class AppButtonText extends TextButton {
  const AppButtonText({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
    required super.child,
  });

  static Widget loading({
    Key? key,
    required bool isLoading,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget child,
  }) {
    return IgnorePointer(
      ignoring: isLoading,
      child: AppButtonText(
        key: key,
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        clipBehavior: clipBehavior ?? Clip.none,
        child: AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: isLoading ? const AppLoaderButton() : child,
        ),
      ),
    );
  }

  static Widget icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) {
    return TextButton.icon(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      icon: icon,
      label: label,
    );
  }
}
