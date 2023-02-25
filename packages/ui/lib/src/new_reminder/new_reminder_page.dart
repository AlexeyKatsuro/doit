import 'package:localization/localization.dart';
import 'package:ui/ui.dart';
import 'package:ui_kit/ui_kit.dart';

class NewReminderPage extends StatelessWidget {
  const NewReminderPage({super.key, required this.viewModel});

  final NewReminderViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newReminderTitle),
        actions: [
          Center(
            child: AppButtonIcon(
              enable: viewModel.isAddEnabled,
              onPressed: viewModel.onAddPressed,
              icon: const Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          AppTextField.new.fromViewModel(
            viewModel.title,
            l10n: l10n,
            labelText: l10n.newReminderTitleInputHint,
          ),
          AppTextField.new.fromViewModel(
            viewModel.title,
            l10n: l10n,
            labelText: l10n.newReminderNotesInputHint,
          ),
          AppCard(
            child: AppTile(
              onTap: viewModel.onDetailsPressed,
              title: Text(l10n.newReminderDetails),
              trailing: const NavTrailing(),
            ),
          ),
          AppCard(
            child: AppTile(
              onTap: viewModel.onListPressed,
              title: Text(l10n.newReminderList),
              trailing: NavTrailing(label: Text(viewModel.selectedListName)),
            ),
          ),
        ].divide(
          divider: const Gap(16),
        ),
      ),
    );
  }
}