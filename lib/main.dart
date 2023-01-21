import 'package:doit/features/auth/common/auth_store.dart';
import 'package:doit/features/common/index.dart';
import 'package:doit/features/language/override/language_system_view_model.dart';
import 'package:doit/features/language/stores/language_store.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'di/dependencies.dart';
import 'features/language/override/language_override.dart';
import 'features/navigation/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  await initDependencies();

  runApp(
    MultiProvider(
      providers: [
        Provider<LanguageStore>(
          create: (context) => injector(),
        ),
        Provider<AuthStore>(
          create: (context) => injector(),
        ),
        Provider<ValueNotifier<AuthorizationStatus>>(
          create: (context) {
            final authStore = context.read<AuthStore>();
            return ValueNotifier(authStore.status);
          },
          dispose: (context, notifier) => notifier.dispose(),
          builder: (context, child) {
            return Reactions.single(
              create: (context) {
                final authStore = context.read<AuthStore>();
                final notifier = context.read<ValueNotifier<AuthorizationStatus>>();
                return reaction((_) => authStore.status, (status) => notifier.value = status);
              },
              child: child!,
            );
          },
        ),
        Provider<GoRouter>(
          create: (context) {
            final router = routerBuilder(context);
            injector.registerSingleton<GoRouter>(router);
            return router;
          },
          dispose: (context, router) => injector.unregister<GoRouter>(instance: router),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: context.watch<GoRouter>(),
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      builder: (context, child) {
        if (child == null) return const SizedBox();
        return Provider<LanguageSystemViewModel>(
            child: child,
            create: (context) => injector(),
            builder: (context, child) {
              return LocaleOverride(
                viewModel: Provider.of(context),
                child: child!,
              );
            });
      },
    );
  }
}
