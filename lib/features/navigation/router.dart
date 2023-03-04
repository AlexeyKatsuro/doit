import 'package:doit/di/dependencies.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';

abstract class RouteNames {
  static const signIn = 'sign-in';
  static const signUp = 'sign-up';
  static const home = 'home';
  static const newReminder = 'new-reminder';
}

GoRouter routerBuilder(BuildContext context) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (_, state) {
            final status = context.read<ValueNotifier<AuthorizationStatus>>().value;
            switch (status) {
              case AuthorizationStatus.processing:
                return null;
              case AuthorizationStatus.authorized:
                return '/home';
              case AuthorizationStatus.unauthorized:
                return '/auth/sign-in';
            }
          },
          builder: (context, state) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        GoRoute(
          name: RouteNames.signIn,
          path: '/auth/sign-in',
          builder: (context, state) {
            return Provider<SignInViewModel>(
              create: (_) => injector(),
              builder: (context, _) => SignInPage(viewModel: Provider.of(context)),
            );
          },
        ),
        GoRoute(
          name: RouteNames.signUp,
          path: '/auth/sign-up',
          builder: (context, state) {
            return Provider<SignUpViewModel>(
              create: (_) => injector(),
              builder: (context, _) => SignUpPage(viewModel: Provider.of(context)),
            );
          },
        ),
        GoRoute(
          path: '/home',
          name: RouteNames.home,
          builder: (context, state) {
            return Provider<HomeViewModel>(
              create: (_) => injector(),
              builder: (context, _) => HomePage(viewModel: Provider.of(context)),
            );
          },
        ),
        GoRoute(
          path: '/${RouteNames.newReminder}',
          name: RouteNames.newReminder,
          builder: (context, state) {
            return Provider<NewReminderViewModel>(
              create: (_) => injector(),
              builder: (context, _) => NewReminderPage(viewModel: Provider.of(context)),
            );
          },
        ),
      ],
      redirect: (context, state) {
        final status = context.read<ValueNotifier<AuthorizationStatus>>().value;
        switch (status) {
          case AuthorizationStatus.processing:
            return '/';
          case AuthorizationStatus.authorized:
            if (!state.location.startsWith('/auth')) return null;
            return '/home';
          case AuthorizationStatus.unauthorized:
            if (state.location.startsWith('/auth')) return null;
            return '/auth/sign-in';
        }
      },
      refreshListenable: context.read<ValueNotifier<AuthorizationStatus>>(),
    );
