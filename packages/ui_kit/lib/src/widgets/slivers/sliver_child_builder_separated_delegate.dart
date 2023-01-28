import 'dart:math';
import 'package:flutter/material.dart';

class SliverChildBuilderSeparatedDelegate extends SliverChildBuilderDelegate {
  SliverChildBuilderSeparatedDelegate({
    required this.itemBuilder,
    required this.separatorBuilder,
    required int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    int semanticIndexOffset = 0,
  }) : super(
          _makeSeparatedBuilder(itemBuilder, separatorBuilder),
          childCount: _makeChildCount(itemCount),
          semanticIndexCallback: _makeSemanticIndexCallback,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexOffset: semanticIndexOffset,
        );
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;

  static IndexedWidgetBuilder _makeSeparatedBuilder(
      IndexedWidgetBuilder itemBuilder, IndexedWidgetBuilder separatorBuilder) {
    return (BuildContext context, int index) {
      final int itemIndex = index ~/ 2;
      if (index.isEven) {
        return itemBuilder(context, itemIndex);
      }
      return separatorBuilder(context, itemIndex);
    };
  }

  static int _makeChildCount(int itemCount) => max(0, itemCount * 2 - 1);

  static int? _makeSemanticIndexCallback(Widget widget, int localIndex) {
    if (localIndex.isEven) {
      return localIndex ~/ 2;
    }
    return null;
  }
}
