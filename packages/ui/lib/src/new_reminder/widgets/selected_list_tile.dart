import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';

import 'selected_list_view_model.dart';

class SelectedListTile extends StatelessWidget {
  const SelectedListTile({super.key, required this.viewModel});

  final SelectedListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final l10n = context.l10n;
      return viewModel.when(
        loaded: (vm) {
          return AppCard(
            child: AppTile(
              onTap: vm.onPressed,
              title: Text(l10n.newReminderList),
              trailing: NavTrailing(
                label: Text(vm.selectedListName.localize(l10n)),
              ),
            ),
          );
        },
        error: (vm) {
          return AppCardError(
            label: Text(vm.errorMessage.localize(l10n)),
            onPressed: vm.onRetry,
          );
        },
        loading: (vm) {
          return const Center(child: AppLoader());
        },
      );
    });
  }
}
