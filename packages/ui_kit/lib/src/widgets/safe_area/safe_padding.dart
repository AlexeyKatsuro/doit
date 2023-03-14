import 'package:flutter/widgets.dart';

import 'extensions.dart';

class SafePadding extends StatelessWidget {
  const SafePadding({
    super.key,
    EdgeInsets? min,
    this.max,
    EdgeInsets? extra,
    bool? maintainBottomViewPadding,
    bool? left,
    bool? top,
    bool? right,
    bool? bottom,
    required this.child,
  })  : min = min ?? EdgeInsets.zero,
        extra = extra ?? EdgeInsets.zero,
        left = left ?? true,
        top = top ?? true,
        right = right ?? true,
        bottom = bottom ?? true,
        maintainBottomViewPadding = maintainBottomViewPadding ?? false;

  const SafePadding.only({
    super.key,
    EdgeInsets? min,
    this.max,
    EdgeInsets? extra,
    bool? maintainBottomViewPadding,
    bool? left,
    bool? top,
    bool? right,
    bool? bottom,
    required this.child,
  })  : min = min ?? EdgeInsets.zero,
        extra = extra ?? EdgeInsets.zero,
        left = left ?? false,
        top = top ?? false,
        right = right ?? false,
        bottom = bottom ?? false,
        maintainBottomViewPadding = maintainBottomViewPadding ?? false;

  SafePadding.top({
    Key? key,
    double? min,
    double? max,
    double? extra,
    required Widget child,
  }) : this.only(
          key: key,
          min: min != null ? EdgeInsets.only(top: min) : null,
          max: max != null ? EdgeInsets.only(top: max) : null,
          extra: extra != null ? EdgeInsets.only(top: extra) : null,
          top: true,
          child: child,
        );

  SafePadding.bottom({
    Key? key,
    double? min,
    double? max,
    double? extra,
    bool? maintainBottomViewPadding,
    required Widget child,
  }) : this.only(
          key: key,
          min: min != null ? EdgeInsets.only(bottom: min) : null,
          max: max != null ? EdgeInsets.only(bottom: max) : null,
          extra: extra != null ? EdgeInsets.only(bottom: extra) : null,
          maintainBottomViewPadding: maintainBottomViewPadding,
          bottom: true,
          child: child,
        );

  final EdgeInsets min;
  final EdgeInsets? max;
  final EdgeInsets extra;
  final bool maintainBottomViewPadding;

  /// Whether to avoid system intrusions on the left.
  final bool left;

  /// Whether to avoid system intrusions at the top of the screen, typically the
  /// system status bar.
  final bool top;

  /// Whether to avoid system intrusions on the right.
  final bool right;

  /// Whether to avoid system intrusions on the bottom side of the screen.
  final bool bottom;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final data = MediaQuery.of(context);
    EdgeInsets padding = data.padding;
    // Bottom padding has been consumed - i.e. by the keyboard
    if (maintainBottomViewPadding) {
      padding = padding.copyWith(bottom: data.viewPadding.bottom);
    }

    final insets = EdgeInsets.only(
      left: left ? ((padding.left + extra.left).coerceIn(min.left, max?.left)) : 0.0,
      top: top ? ((padding.top + extra.top).coerceIn(min.top, max?.top)) : 0.0,
      right: right ? ((padding.right + extra.right).coerceIn(min.right, max?.right)) : 0.0,
      bottom: bottom ? ((padding.bottom + extra.bottom).coerceIn(min.bottom, max?.bottom)) : 0.0,
    );
    return Padding(
      padding: insets,
      child: MediaQuery.removePadding(
        context: context,
        removeLeft: left,
        removeTop: top,
        removeRight: right,
        removeBottom: bottom,
        child: child,
      ),
    );
  }
}
