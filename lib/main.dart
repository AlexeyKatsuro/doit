import 'package:doit/features/language/override/language_system_view_model.dart';
import 'package:doit/features/language/stores/language_store.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import 'di/dependencies.dart';
import 'features/language/override/language_override.dart';
import 'features/navigation/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiProvider(
      providers: [
        Provider<LanguageStore>(
          create: (context) => injector(),
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
      routerConfig: router,
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(primarySwatch: Colors.blue),
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
