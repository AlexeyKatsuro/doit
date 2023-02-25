import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui/src/common/index.dart';
import 'package:ui_kit/ui_kit.dart';

import '../task_view_model.dart';

class Task extends StatefulWidget {
  const Task({super.key, required this.viewModel});

  final TaskViewModel viewModel;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool _isTitleFocused = false;

  late final _titleFocusNode = FocusNode()..addListener(_onFocusChange);
  late final _subtitleFocusNode = FocusNode();

  void _onFocusChange() {
    if (_isTitleFocused != _titleFocusNode.hasFocus) {
      setState(() {
        _isTitleFocused = _titleFocusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _titleFocusNode.removeListener(_onFocusChange);
    _titleFocusNode.dispose();
    super.dispose();
  }

  bool get _isSubtitleVisible =>
      _isTitleFocused || _subtitleFocusNode.hasFocus || widget.viewModel.subTitle.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Observer(builder: (context) {
          return Checkbox(
            value: widget.viewModel.isCompleted,
            onChanged: (value) {
              widget.viewModel.onStatusChanged(value ?? false);
            },
          );
        }),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Observer(builder: (context) {
                return AppTextField.new.fromViewModel(
                  widget.viewModel.title,
                  l10n: l10n,
                  focusNode: _titleFocusNode,
                );
              }),
              Observer(builder: (context) {
                return AnimatedCrossFade(
                    duration: kThemeChangeDuration,
                    crossFadeState:
                        _isSubtitleVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    secondChild: const SizedBox.shrink(),
                    firstChild: AppTextField.new.fromViewModel(widget.viewModel.subTitle,
                        l10n: l10n, hintText: l10n.taskNoteHint, focusNode: _subtitleFocusNode));
              }),
            ],
          ),
        ),
      ],
    );
  }
}
