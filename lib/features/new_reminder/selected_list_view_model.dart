import 'dart:developer';
import 'dart:ui';

import 'package:doit/features/common/index.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'selected_list_view_model.g.dart';

@Injectable(as: SelectedListViewModel)
class SelectedListViewModelImpl extends SelectedListViewModelBase with _$SelectedListViewModelImpl {
  SelectedListViewModelImpl(super.remindersRepository);

  @override
  @postConstruct
  void init() {
    return super.init();
  }
}

abstract class SelectedListViewModelBase extends SelectedListViewModel with Store, RunAsync {
  SelectedListViewModelBase(this._listsRepository);

  final ListsRepository _listsRepository;

  @override
  void init() {
    _fetchDefaultReminderList();
  }

  @override
  SelectedListLoadedViewModelImpl get asLoaded => super.asLoaded as SelectedListLoadedViewModelImpl;

  @action
  Future<void> _fetchDefaultReminderList() async {
    state = const SelectedListLoadingViewModelImpl();
    try {
      final defaultReminderList = await _listsRepository.getDefaultReminderList();
      state = SelectedListLoadedViewModelImpl(
        listId: defaultReminderList.id,
        selectedListName: UiMessage.text(defaultReminderList.name),
        onPressed: () {},
      );
    } catch (error, stackTrace) {
      log('getDefaultReminderList Error', error: error, stackTrace: stackTrace);
      state = SelectedListErrorViewModelImpl(
        errorMessage: error.toUiMessage(),
        onRetry: _fetchDefaultReminderList,
      );
    }
  }
}


