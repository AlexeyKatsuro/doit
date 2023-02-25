import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ui/src/all_reminder/task_list_view_model.dart';
import 'package:ui/src/all_reminder/widgets/task.dart';
import 'package:ui_kit/ui_kit.dart';

class TaskListSliver extends StatelessWidget {
  const TaskListSliver({super.key, required this.viewModel});

  final TaskListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(builder: (context) {
      return MultiSliver(children: [
        Observer(builder: (context) {
          return Text(
            viewModel.name,
            style: theme.textTheme.titleLarge,
          );
        }),
        const Gap(12),
        SliverList(
            delegate: SliverChildBuilderSeparatedDelegate(
          itemCount: viewModel.tasks.length,
          separatorBuilder: (context, index) => const Divider(indent: 48),
          itemBuilder: (context, index) {
            return Observer(
              builder: (context) {
                final task = viewModel.tasks[index];
                return Task(viewModel: task);
              },
            );
          },
        ))
      ]);
    });
  }
}
