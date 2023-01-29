import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'home_view_model.g.dart';

@injectable
class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {
  @observable
  String value = 'Home';

  @computed
  String get fullName => value;

  @action
  void onPressed() {}
}
