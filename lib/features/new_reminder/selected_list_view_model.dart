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

abstract class SelectedListViewModelBase extends SelectedListViewModel with Store {
  SelectedListViewModelBase(this._listsRepository);

  final ListsRepository _listsRepository;

  @override
  @observable
  Object state = const SelectedListLoadingViewModelImpl();

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

class SelectedListLoadedViewModelImpl extends SelectedListLoadedViewModel {
  const SelectedListLoadedViewModelImpl({
    required VoidCallback onPressed,
    required this.selectedListName,
    required this.listId,
  }) : _onPressed = onPressed;

  final VoidCallback _onPressed;
  final Object listId;

  @override
  final UiMessage selectedListName;

  @override
  void onPressed() {
    _onPressed.call();
  }
}

class SelectedListErrorViewModelImpl extends SelectedListErrorViewModel {
  const SelectedListErrorViewModelImpl({
    required VoidCallback onRetry,
    required this.errorMessage,
  }) : _onRetry = onRetry;

  final VoidCallback _onRetry;

  @override
  final UiMessage errorMessage;

  @override
  void onRetry() {
    _onRetry.call();
  }
}

class SelectedListLoadingViewModelImpl extends SelectedListLoadingViewModel {
  const SelectedListLoadingViewModelImpl();
}
