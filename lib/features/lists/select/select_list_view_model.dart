import 'package:doit/features/common/index.dart';
import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

import 'widgets/list_view_model.dart';

part 'select_list_view_model.g.dart';

class SelectListViewModelImpl extends SelectListViewModelBase with _$SelectListViewModelImpl {
  SelectListViewModelImpl(
    super.router,
    super.listsRepository,
    super.selectedListId,
  );

  @override
  @postConstruct
  void init() => super.init();
}

abstract class SelectListViewModelBase extends SelectListViewModel with Store, RunAsync {
  SelectListViewModelBase(this._router, this._listsRepository, this.selectedListId);

  final GoRouter _router;
  final ListsRepository _listsRepository;

  late final Async<List<ReminderList>> _reminderList = runAsync(() {
    return _listsRepository.getAllLists();
  });

  Object selectedListId;

  @override
  late Async<List<ListViewModel>> lists = _reminderList.map((lists) {
    return [
      for (final list in lists)
        ListViewModelImpl(
          name: UiMessage.text(list.name),
          icon: IconType.flag,
          onPressed: () {
            _onSelectNewList(list.id);
            _router.pop();
          },
          isSelected: list.id == selectedListId,
        ),
    ];
  });

  @action
  void _onSelectNewList(Object id) {
    selectedListId = id;
  }
}
