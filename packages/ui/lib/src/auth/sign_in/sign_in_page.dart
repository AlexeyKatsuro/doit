import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';

import 'sign_in_view_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key, required this.viewModel});

  final SignInViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
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
              return AppButtonFilled.loading(
                isLoading: viewModel.isLoading,
                onPressed: viewModel.onLoginPressed,
                child: const Text('Login'),
              );
            }),
            AppButtonOutlined(
              onPressed: viewModel.onRegisterPressed,
              child: const Text('Sign Up'),
            ),
          ].divide(divider: const Gap(10)),
        ),
      ),
    );
  }
}
