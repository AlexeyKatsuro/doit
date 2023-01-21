import 'package:doit/features/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../auth/common/auth_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (context) {
          return Text(viewModel.value);
        }),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<AuthStore>().logout();
            },
            child: Text(l10n.logout),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthStore>().logout();
            },
            child: Text(l10n.homeNewReminder),
          )
        ],
      ),
    );
  }
}
