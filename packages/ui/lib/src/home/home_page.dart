import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui/src/common/factories/index.dart';
import 'package:ui/src/home/home_view_model.dart';
import 'package:ui/src/home/widgets/dashboard_card.dart';
import 'package:ui_kit/ui_kit.dart';

import 'widgets/task_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: PopupMenuButton<void>(
              itemBuilder: (context) {
                final l10n = context.l10n;
                return [
                  PopupMenuItem<void>(
                    onTap: viewModel.onEditListsPressed,
                    child: MenuTile(
                      label: Text(l10n.homeMenuEditLists),
                      icon: const Icon(Icons.edit_rounded),
                    ),
                  ),
                  PopupMenuItem<void>(
                    onTap: viewModel.onTemplatesPressed,
                    child: MenuTile(
                      label: Text(l10n.homeMenuTemplates),
                      icon: const Icon(Icons.copy_rounded),
                    ),
                  ),
                  PopupMenuItem<void>(
                    onTap: viewModel.onLogoutPressed,
                    child: MenuTile(
                      label: Text(l10n.homeMenuLogout),
                      icon: const Icon(Icons.logout_rounded),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: MultiSliver(
              children: [
                Observer(builder: (context) {
                  return AppTextField.new.fromViewModel(
                    viewModel.search,
                    l10n: l10n,
                    labelText: l10n.homeSearchHint,
                  );
                }),
                const Gap(16),
                Observer(builder: (context) {
                  return SliverGridIntrinsicRow(
                    itemCount: viewModel.dashboard.length,
                    crossAxisCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return DashboardTile(
                        viewModel: viewModel.dashboard[index],
                      );
                    },
                  );
                }),
                const Gap(20),
                Text(l10n.homeMyListsHeader, style: theme.textTheme.titleLarge),
                const Gap(8),
                AppCard(
                  clipBehavior: Clip.antiAlias,
                  child: Observer(builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final list in viewModel.lists) TaskListTile(viewModel: list),
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.onAddReminderPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
