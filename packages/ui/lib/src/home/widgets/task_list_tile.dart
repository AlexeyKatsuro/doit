import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';
import 'package:ui_kit/ui_kit.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.viewModel,
  });

  final TaskListTileViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Observer(builder: (context) {
      return AppTile(
        leading: Icon(viewModel.icon.toMaterialIconData()),
        title: Text(viewModel.name.localize(l10n)),
        dense: true,
        onTap: viewModel.onPressed,
        trailing: NavTrailing(
          label: Text('${viewModel.count}'),
        ),
      );
    });
  }
}
