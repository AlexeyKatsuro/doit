import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart' as mobx show enableWarnWhenNoObservables;
import 'package:localization/localization.dart';

import 'features/routes.dart';

void main() {
  mobx.enableWarnWhenNoObservables = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => RoutesPage(routes: routes),
        ...routes,
      },
    );
  }
}

class RoutesPage extends StatelessWidget {
  const RoutesPage({super.key, required this.routes});

  final Map<String, WidgetBuilder> routes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final route in routes.keys)
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, route);
                },
                child: Text(route),
              ),
          ],
        ),
      ),
    );
  }
}
