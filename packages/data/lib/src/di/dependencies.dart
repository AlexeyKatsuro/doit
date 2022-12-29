import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependencies.config.dart';

typedef Injector = GetIt;

late final Injector injector;

@InjectableInit()
Future<void> initDependencies(Injector parentInjector) {
  injector = parentInjector;
 return  injector.init();
}
