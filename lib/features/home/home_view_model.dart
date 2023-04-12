import 'package:doit/features/common/run_async.dart';
import 'package:doit/features/common/stores/text_field_view_model.dart';
import 'package:doit/features/home/task_list_tile_view_model.dart';
import 'package:doit/features/navigation/router.dart';
import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'home_view_model.g.dart';

@Injectable(as: HomeViewModel)
class HomeViewModelImpl extends HomeViewModelBase with _$HomeViewModelImpl {
  HomeViewModelImpl(super.authRepository, super.router, super.listsRepository);

  @override
  @postConstruct
  void init() => super.init();
}

abstract class HomeViewModelBase extends HomeViewModel with Store, RunAsync {
  HomeViewModelBase(
    this._authRepository,
    this._router,
    this._listsRepository,
  );

  final AuthRepository _authRepository;
  final ListsRepository _listsRepository;
  final GoRouter _router;

  @override
  @observable
  late Async<List<DashboardTileViewModel>> dashboard = runAsync(() async {
    return [];
  });

  @override
  @observable
  late bool isEditMode = false;

  late final Async<List<CountOf<ReminderList>>> _lists = runAsync(() async {
    return _listsRepository.getAllListsWithCount();
  });

  @override
  late Async<List<TaskListTileViewModel>> lists = _lists.map((data) {
    return [
      for (final list in data)
        TaskListTileViewModelImpl(
          count: list.count,
          icon: IconType.flag,
          name: UiMessage.text(list.data.name),
          onPressed: () {},
        ),
    ];
  });

  @override
  late TextFieldViewModel search = TextFieldViewModelImpl();

  @action
  Future<void> _onInit() async {}

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
    _router.pushNamed(RouteNames.newList);
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
