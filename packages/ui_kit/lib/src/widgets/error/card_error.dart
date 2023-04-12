import 'package:ui_kit/ui_kit.dart';

class AppCardError extends StatelessWidget {
  const AppCardError({
    super.key,
    required this.label,
    this.onPressed,
  });

  final Widget label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: AppTile(
        onTap: onPressed,
        title: label,
        leading: const Icon(Icons.error),
        trailing: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}
