import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';

import 'sign_up_view_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key, required this.viewModel});

  final SignUpViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Observer(builder: (context) {
              return AppEmailField(
                text: viewModel.email.value,
                onChanged: viewModel.email.onChanged,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: viewModel.email.errorMessage?.tryLocalize(l10n),
                ),
              );
            }),
            Observer(builder: (context) {
              return AppPasswordField(
                text: viewModel.password.value,
                onChanged: viewModel.password.onChanged,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: viewModel.password.errorMessage?.tryLocalize(l10n),
                ),
              );
            }),
            Observer(builder: (context) {
              return AppPasswordField(
                text: viewModel.repeatPassword.value,
                onChanged: viewModel.repeatPassword.onChanged,
                decoration: InputDecoration(
                  labelText: 'Repeat password',
                  errorText: viewModel.repeatPassword.errorMessage?.tryLocalize(l10n),
                ),
              );
            }),
            Observer(builder: (context) {
              return AppButtonFilled.loading(
                isLoading: viewModel.isLoading,
                onPressed: viewModel.onRegisterPressed,
                child: const Text('Register'),
              );
            }),
            AppButtonOutlined(
              onPressed: viewModel.onLoginPressed,
              child: const Text('Sign In'),
            ),
          ].divide(divider: const Gap(10)),
        ),
      ),
    );
  }
}
