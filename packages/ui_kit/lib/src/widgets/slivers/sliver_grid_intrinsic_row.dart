import 'package:flutter/material.dart';
import 'package:ui_kit/src/utils/extensions/index.dart';

import 'sliver_child_builder_separated_delegate.dart';


/// Creates grid with intrinsic row which able to aligned with highest widget in this row
///
/// [itemCount] - count of elements to display
/// [crossAxisCount] - how many column will be. [SliverGridIntrinsicRow] has vertical axis as main
/// [mainAxisSpacing] - spacing between columns
/// [crossAxisSpacing] - spacing between rows
/// [itemBuilder] - takes [IndexedWidgetBuilder] function to draw widget inside grid

class SliverGridIntrinsicRow extends StatelessWidget {

  const SliverGridIntrinsicRow({
    Key? key,
    required this.itemCount,
    required this.crossAxisCount,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    required this.itemBuilder,
  })  : assert(crossAxisCount != 0, 'mainAxisCount property can\'t be 0'),
        super(key: key);

  final int itemCount;
  final int crossAxisCount;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderSeparatedDelegate(
        itemBuilder: _buildRow,
        itemCount: (itemCount / crossAxisCount).ceil(),
        separatorBuilder: (context, ind) => SizedBox(height: crossAxisSpacing),
      ),
    );
  }

  Widget _buildRow(BuildContext context, int rowIndex) {
    final startIndex = rowIndex * crossAxisCount;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        crossAxisCount,
        (itemIndex) => Expanded(
          child: startIndex + itemIndex < itemCount
              ? itemBuilder(context, startIndex + itemIndex)
              : const SizedBox.shrink(),
        ),
      ).divide(divider: SizedBox(width: mainAxisSpacing)),
    );
  }
}
