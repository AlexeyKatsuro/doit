import 'package:flutter/material.dart';

import 'app_tile.dart';

class ExpandableTile extends StatelessWidget {
  const ExpandableTile({
    super.key,
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.onChange,
  });

  final bool isExpanded;
  final Widget title;
  final Widget content;
  final ValueChanged<bool>? onChange;

  VoidCallback? _handlePress() => onChange == null ? null : () => onChange!(!isExpanded);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTile(
          onTap: _handlePress(),
          title: title,
          trailing: AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 300),
            child: const Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ),
        AnimatedCrossFade(
          alignment: Alignment.topCenter,
          crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: const SizedBox(width: double.infinity),
          secondChild: content,
          duration: kThemeChangeDuration,
        ),
        if (isExpanded) const Divider(),
      ],
    );
  }
}
