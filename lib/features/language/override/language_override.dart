import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'language_system_view_model.dart';

class LocaleOverride extends StatefulWidget {
  const LocaleOverride({
    super.key,
    required this.viewModel,
    required this.child,
  });

  final LanguageSystemViewModel viewModel;
  final Widget child;

  @override
  State<LocaleOverride> createState() => _LocaleOverrideState();
}

class _LocaleOverrideState extends State<LocaleOverride> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.viewModel.onSystemLocaleChanged(Localizations.localeOf(context));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Localizations.override(
          context: context,
          locale: widget.viewModel.overwritten,
          child: widget.child,
        );
      }
    );
  }
}
