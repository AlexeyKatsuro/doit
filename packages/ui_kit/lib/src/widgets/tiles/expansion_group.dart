import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ExpansionGroup<T extends Object> extends StatefulWidget {
  const ExpansionGroup.multiple({
    super.key,
    required this.builder,
  }) : isMultiSelect = true;

  const ExpansionGroup.single({
    super.key,
    required this.builder,
  }) : isMultiSelect = false;

  static ExpansionGroupController<T> of<T>(BuildContext context) {
    final controller = context.dependOnInheritedWidgetOfExactType<_ExpansionGroupScope<T>>();
    return controller!;
  }

  final bool isMultiSelect;
  final WidgetBuilder builder;

  @override
  State<ExpansionGroup<T>> createState() => _ExpansionGroupState<T>();
}

class _ExpansionGroupState<T extends Object> extends State<ExpansionGroup<T>> {
  Set<T> selected = {};

  void _set(Set<T> element) {
    setState(() {
      selected = element;
    });
  }

  void _onMultiSelectTap(T value) {
    if (selected.contains(value)) {
      selected.remove(value);
    } else {
      selected.add(value);
    }
    _set({...selected});
  }

  void onSingleSelectTap(T value) {
    _set({
      if (selected.firstOrNull != value) value,
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ExpansionGroupScope<T>(
      selected: selected,
      onTap: widget.isMultiSelect ? _onMultiSelectTap : onSingleSelectTap,
      isMultiSelect: widget.isMultiSelect,
      child: widget.builder(context),
    );
  }
}

class _ExpansionGroupScope<T> extends InheritedWidget implements ExpansionGroupController<T> {
  const _ExpansionGroupScope({
    Key? key,
    required this.selected,
    required Widget child,
    required ValueSetter<T> onTap,
    required this.isMultiSelect,
  })  : _onTap = onTap,
        super(key: key, child: child);

  final Set<T> selected;
  final ValueSetter<T> _onTap;
  final bool isMultiSelect;

  @override
  bool updateShouldNotify(_ExpansionGroupScope<T> oldWidget) =>
      !(SetEquality<T>().equals(selected, oldWidget.selected)) ||
      isMultiSelect != oldWidget.isMultiSelect;

  @override
  bool isExpanded(T value) {
    return selected.contains(value);
  }

  @override
  void onTap(T value) => _onTap(value);
}

abstract class ExpansionGroupController<T> {
  bool isExpanded(T value);

  void onTap(T value);
}
