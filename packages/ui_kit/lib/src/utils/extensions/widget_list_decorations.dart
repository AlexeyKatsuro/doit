import 'package:flutter/widgets.dart';

/// Helpful extensions method to modify list of widgets.
extension ListWidgetExt on List<Widget> {
  /// Return new list of widget with inserted [divider] widget between items.
  ///
  /// It similar to [ListView.separated] for [Column] and [Row].
  ///
  /// If [surround] is true then [divider] will add as first and end item.
  ///
  /// ```dart
  /// Column(
  ///   children: const [
  ///     Text('item1'),
  ///     Text('item2'),
  ///     Text('item3'),
  ///   ].divide(divider: const SizedBox(height: 8)),
  /// );
  ///
  /// // Equals to
  ///
  /// Column(
  ///   children: const [
  ///     Text('item1'),
  ///     SizedBox(height: 8),
  ///     Text('item2'),
  ///     SizedBox(height: 8),
  ///     Text('item3'),
  ///   ],
  /// );
  /// ```
  ///
  /// This extension can be very useful for non static lists of widgets
  /// ```dart
  /// Column(
  ///   children: [
  ///     for (final item in items)
  ///       Text(item),
  ///   ].divide(divider: const SizedBox(height: 8)),
  /// );
  /// ```
  List<Widget> divide({
    required Widget divider,
    bool bottom = false,
    bool top = false,
  }) {
    final children = this;
    if (children.isEmpty) return [];
    if (children.length == 1 && !(top || bottom)) return children;

    final listBuilder = <Widget>[];
    if (top) listBuilder.add(divider);
    for (int index = 0; index < children.length; index++) {
      final child = children[index];
      final next = index + 1 < children.length ? children[index + 1] : null;
      listBuilder.add(child);
      if (child.isNotDecoration<IgnoreDivider>() && (bottom || next != null)) {
        listBuilder.add(divider);
      }
    }
    return listBuilder;
  }

  List<Widget> padding({
    required EdgeInsets padding,
    bool surround = false,
  }) {
    return map((child) {
      Widget applyPadding(Widget child) {
        return child.isDecoration<IgnorePadding>()
            ? child
            : Padding(
                padding: padding,
                child: child,
              );
      }

      if (child is Flexible) {
        return Flexible(
          key: child.key,
          flex: child.flex,
          fit: child.fit,
          child: applyPadding(child.child),
        );
      } else if (child is Spacer) {
        return child;
      } else {
        return applyPadding(child);
      }
    }).toList(growable: false);
  }
}

abstract class WidgetDecoration extends StatelessWidget {
  const WidgetDecoration({
    Key? key,
    required this.child,
    required this.active,
  }) : super(key: key);

  final Widget child;

  final bool active;

  @override
  Widget build(BuildContext context) => child;
}

extension on Widget {
  bool isDecoration<T extends WidgetDecoration>() {
    if (this is T) return (this as T).active;
    if (this is WidgetDecoration) {
      return (this as WidgetDecoration).child.isDecoration<T>();
    }
    return false;
  }

  //Widget get peelUp => this is WidgetDecoration ? (this as WidgetDecoration).child.peelUp : this;

  bool isNotDecoration<T extends WidgetDecoration>() => !isDecoration<T>();
}

/// Fake widget that used for [ListWidgetExt.padding] extension.
class IgnorePadding extends WidgetDecoration {
  const IgnorePadding({Key? key, required Widget child, bool isActive = true})
      : super(key: key, child: child, active: isActive);
}

/// Fake widget that used for [ListWidgetExt.divide] extension.
class IgnoreDivider extends WidgetDecoration {
  const IgnoreDivider({Key? key, required Widget child, bool isActive = true})
      : super(key: key, child: child, active: isActive);
}
