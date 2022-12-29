import 'package:doit/di/dependencies.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:data/data.dart' as data;

typedef Injector = GetIt;

final Injector injector = GetIt.instance;

@InjectableInit()
Future<void> initDependencies() async {
  await data.initDependencies(injector);
  injector.init();
  return injector.allReady(timeout: const Duration(seconds: 1));
}
