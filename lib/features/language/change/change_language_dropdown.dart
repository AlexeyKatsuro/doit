import 'package:doit/features/language/change/matchers/locale_matcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';

import 'change_language_view_model.dart';


class ChangeLanguageDropdown extends StatelessWidget {
  const ChangeLanguageDropdown({super.key, required this.viewModel});

  final ChangeLanguageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Observer(
      builder: (context) {
        final options = viewModel.options;
        return Center(
          child: PopupMenuButton<Locale>(
            onSelected: (Locale locale) {
              viewModel.onOptionPressed(locale);
            },
            itemBuilder: (context) => [
              for (final option in options)
                PopupMenuItem<Locale>(
                  value: option,
                  child: Observer(
                    builder: (context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(option.localize(context)),
                          if (option == viewModel.locale) const Icon(Icons.check),
                        ].divide(divider: const Gap(5)),
                      );
                    }
                  ),
                ),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language_outlined),
                const Gap(5),
                Text(l10n.languageLabel),
              ],
            ),
          ),
        );
      }
    );
  }
}
