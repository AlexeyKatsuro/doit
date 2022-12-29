import 'package:flutter/material.dart';


abstract class AppButtonToggleableStyles {
  static ButtonStyle defaultStyle(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
      foregroundColor: theme.colorScheme.primary,
      disabledForegroundColor: theme.colorScheme.onSurface.withOpacity(0.38),
      backgroundColor: Colors.transparent,
      disabledBackgroundColor: Colors.transparent,
      shadowColor: theme.shadowColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      minimumSize: const Size(64, 36),
      maximumSize: Size.infinite,
      side: BorderSide(
        color: Theme.of(context).colorScheme.primary,
      ),
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.basic,
      visualDensity: theme.visualDensity,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkRipple.splashFactory,
    );
  }

  static ButtonStyle defaultCheckedStyle(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
      foregroundColor: theme.colorScheme.primary,
      disabledBackgroundColor: theme.colorScheme.onSurface.withOpacity(0.12),
      disabledForegroundColor: theme.colorScheme.onSurface.withOpacity(0.38),
      shadowColor: theme.shadowColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      minimumSize: const Size(64, 36),
      maximumSize: Size.infinite,
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.basic,
      visualDensity: theme.visualDensity,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkRipple.splashFactory,
    );
  }
}
