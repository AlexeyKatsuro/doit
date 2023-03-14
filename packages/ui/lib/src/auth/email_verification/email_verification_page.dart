import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';

import 'email_verification_view_model.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key, required this.viewModel});

  final EmailVerificationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.emailVerificationTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Observer(builder: (context) {
              return Text(l10n.emailVerificationHint(viewModel.email));
            }),
            AppButtonFilled(
              onPressed: viewModel.onCheckEmailPressed,
              child: Text(
                l10n.emailVerificationCheck,
              ),
            ),
            AppButtonOutlined(
              onPressed: viewModel.onCancelPressed,
              child: Text(l10n.emailVerificationCancel),
            ),
            const IgnoreDivider(
                child: SafeGap.bottom(
              minValue: 10,
            ))
          ].divide(divider: const Gap(10)),
        ),
      ),
    );
  }
}
