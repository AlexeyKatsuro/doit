import 'package:doit/di/dependencies.dart';
import 'package:doit/features/auth/sign_in/sign_in_page.dart';
import 'package:doit/features/auth/sign_in/sign_in_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return Provider<SignInViewModel>(
        create: (_) => injector(),
        builder: (context, _) => SignInPage(viewModel: Provider.of(context)),
      );
    },
  ),
]);
