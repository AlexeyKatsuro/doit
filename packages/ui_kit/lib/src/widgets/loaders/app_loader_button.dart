
import 'package:flutter/material.dart';

class AppLoaderButton extends StatelessWidget {
  const AppLoaderButton({super.key});

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return SizedBox.square(
      dimension: iconTheme.size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: iconTheme.color,
      ),
    );
  }
}
