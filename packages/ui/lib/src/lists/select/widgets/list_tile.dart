import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';
import 'package:ui_kit/ui_kit.dart';

class ListTile extends StatelessWidget {
  const ListTile({
    super.key,
    required this.viewModel,
  });

  final ListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final l10n = context.l10n;
      final theme = Theme.of(context);
      return AppTile(
        leading: Icon(viewModel.icon.toMaterialIconData()),
        title: Text(viewModel.name.localize(l10n)),
        dense: true,
        onTap: viewModel.onPressed,
        trailing: AnimatedSwitcher(
          duration: kThemeChangeDuration,
          child: viewModel.isSelected
              ? Icon(
                  Icons.check_rounded,
                  color: theme.colorScheme.primary,
                )
              : const SizedBox.shrink(),
        ),
      );
    });
  }
}
