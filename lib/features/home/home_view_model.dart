import 'package:doit/features/common/stores/text_field_view_model.dart';
import 'package:doit/features/navigation/router.dart';
import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'home_view_model.g.dart';

@Injectable(as: HomeViewModel)
class HomeViewModelImpl = HomeViewModelBase with _$HomeViewModelImpl;

abstract class HomeViewModelBase extends HomeViewModel with Store {
  HomeViewModelBase(
    this._authRepository,
    this._router,
    this._remindersRepository,
  );

  final AuthRepository _authRepository;
  final RemindersRepository _remindersRepository;
  final GoRouter _router;

  @override
  @observable
  late List<DashboardTileViewModel> dashboard = [];

  @override
  @observable
  late bool isEditMode = false;

  @override
  @observable
  late List<TaskListTileViewModel> lists = [];

  @override
  late TextFieldViewModel search = TextFieldViewModelImpl();

  @action
  Future<void> _onInit() async {
    final count = await _remindersRepository.allReminderCount();
    lists = [];
  }

  @action
  Future<void> _logout() async {
    try {
      await _authRepository.signOut();
    } catch (error) {
      // TODO Error
    }
  }

  @override
  @action
  void onAddGroupPressed() {
    // TODO: implement onAddGroupPressed
  }

  @override
  void onAddListPressed() {
    // TODO: implement onAddListPressed
  }

  @override
  void onAddReminderPressed() {
    _router.pushNamed(RouteNames.newReminder);
  }

  @override
  void onDashboardListOrderChanged(List<DashboardTileViewModel> ordered) {
    // TODO: implement onDashboardListOrderChanged
  }

  @override
  void onEditListsPressed() {
    // TODO: implement onEditListsPressed
  }

  @override
  void onTaskListOrderChanged(List<TaskListTileViewModel> ordered) {
    // TODO: implement onTaskListOrderChanged
  }

  @override
  void onTemplatesPressed() {
    // TODO: implement onTemplatesPressed
  }

  @override
  void onLogoutPressed() {
    _logout();
  }
}
