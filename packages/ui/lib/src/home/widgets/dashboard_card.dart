import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';
import 'package:ui_kit/ui_kit.dart';

class DashboardTile extends StatelessWidget {
  const DashboardTile({
    super.key,
    required this.viewModel,
  });

  final DashboardTileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return AppCard(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: viewModel.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0) +
              const EdgeInsets.only(top: 8, bottom: 4),
          child: Observer(builder: (context) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(viewModel.icon.toMaterialIconData()),
                      const Gap(8),
                      Text(viewModel.name.localize(l10n))
                    ],
                  ),
                ),
                Text(
                  '${viewModel.count}',
                  style: theme.textTheme.headline6,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
