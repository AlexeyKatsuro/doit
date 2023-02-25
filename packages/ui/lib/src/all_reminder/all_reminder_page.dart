import 'package:localization/localization.dart';
import 'package:ui/src/all_reminder/widgets/task_list.dart';
import 'package:ui_kit/ui_kit.dart';

import 'all_reminder_page_view_model.dart';

class AllReminderPage extends StatelessWidget {
  const AllReminderPage({
    super.key,
    required this.viewModel,
  });

  final AllReminderPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.allTaskListsTitle),
      ),
      body: CustomScrollView(
        slivers: [
          for (final list in viewModel.lists)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: TaskListSliver(
                viewModel: list,
              ),
            ),
        ].divide(divider: const SliverGap(20)),
      ),
    );
  }
}
