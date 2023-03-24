import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';
import 'package:ui_kit/ui_kit.dart';

class ListCommonPage extends StatelessWidget {
  const ListCommonPage({super.key, required this.viewModel});

  final ListCommonPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (context) {
          return Text(viewModel.title.localize(l10n));
        }),
        actions: [
          Center(
            child: Observer(builder: (context) {
              return viewModel.submitStatus.whenOrElse(
                loading: () {
                  return Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    child: const AppLoaderButton(),
                  );
                },
                orElse: () {
                  return AppButtonIcon(
                    enable: viewModel.isSubmitEnabled,
                    onPressed: viewModel.onSubmitPressed,
                    icon: const Icon(Icons.add_rounded),
                  );
                },
              );
            }),
          ),
        ],
      ),
      body: SafePadding(
        min: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Observer(builder: (context) {
              return viewModel.listNameField.when(
                loaded: (nameTextField) {
                  return AppTextField.new.fromViewModel(
                    nameTextField,
                    l10n: l10n,
                    hintText: l10n.listsBuilderFieldHint,
                    errorText: viewModel.submitStatus.errorMessage?.tryLocalize(l10n),
                  );
                },
                error: (errorMessage) {
                  return AppCardError(label: Text(errorMessage.localize(l10n)));
                },
                loading: () {
                  return AppTextField(
                    text: null,
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: l10n.listsBuilderFieldHint,
                      suffixIcon: const AppLoaderButton(),
                      suffixIconConstraints: const BoxConstraints.tightFor(height: 24, width: 24),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
