import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircularProgressIndicator(
      color: theme.colorScheme.primary,
    );
  }
}
