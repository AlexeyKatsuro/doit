import 'package:localization/localization.dart';
import 'package:ui/src/utils/async_builder.dart';
import 'package:ui_kit/ui_kit.dart' hide ListTile;

import 'select_list_view_model.dart';
import 'widgets/list_tile.dart';

class SelectListPage extends StatelessWidget {
  const SelectListPage({super.key, required this.viewModel});

  final SelectListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectListTitle),
      ),
      body: SafePadding(
        extra: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: AsyncBuilder(
          async: viewModel.lists,
          loaded: (context, list) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(viewModel: list[index]);
              },
              itemCount: list.length,
            );
          },
        ),
      ),
    );
  }
}
