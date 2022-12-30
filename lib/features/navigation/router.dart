import 'package:doit/di/dependencies.dart';
import 'package:doit/features/auth/sign_in/sign_in_page.dart';
import 'package:doit/features/auth/sign_in/sign_in_view_model.dart';
import 'package:doit/features/auth/sign_up/sign_up_page.dart';
import 'package:doit/features/auth/sign_up/sign_up_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(initialLocation: '/sign-in', routes: [
  GoRoute(
    path: '/',
    redirect: (_, __) => '/sign-in',
  ),
  GoRoute(
      name: 'sign-in',
      path: '/sign-in',
      builder: (context, state) {
        return Provider<SignInViewModel>(
          create: (_) => injector(),
          builder: (context, _) => SignInPage(viewModel: Provider.of(context)),
        );
      },
      routes: [
        GoRoute(
          name: 'sign-up',
          path: 'sign-up',
          builder: (context, state) {
            return Provider<SignUpViewModel>(
              create: (_) => injector(),
              builder: (context, _) => SignUpPage(viewModel: Provider.of(context)),
            );
          },
        ),
      ]),
  GoRoute(
    path: '/sign-up',
    builder: (context, state) {
      return Provider<SignUpViewModel>(
        create: (_) => injector(),
        builder: (context, _) => SignUpPage(viewModel: Provider.of(context)),
      );
    },
  ),
]);
