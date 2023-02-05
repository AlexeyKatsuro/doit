import 'package:flutter/material.dart';

class NavTrailing extends StatelessWidget {
  const NavTrailing({super.key, this.label});

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) label!,
        const Icon(Icons.arrow_forward_ios_rounded),
      ],
    );
  }
}
