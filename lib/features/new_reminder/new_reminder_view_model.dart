import 'dart:async';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:doit/features/common/index.dart';
import 'package:doit/features/new_reminder/selected_list_view_model.dart';
import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

import '../navigation/router.dart';

part 'new_reminder_view_model.g.dart';

@Injectable(as: NewReminderViewModel)
class NewReminderViewModelImpl extends NewReminderViewModelBase with _$NewReminderViewModelImpl {
  NewReminderViewModelImpl(super.remindersRepository, super.router, super.selectedListViewModel);

  @override
  @postConstruct
  void init() {
    return super.init();
  }
}

abstract class NewReminderViewModelBase extends NewReminderViewModel with Store {
  NewReminderViewModelBase(this._remindersRepository, this._router, this.selectedListViewModel);

  final RemindersRepository _remindersRepository;
  final GoRouter _router;

  @override
  @observable
  TextFieldViewModel title = TextFieldViewModelImpl();

  @override
  @observable
  TextFieldViewModel subTitle = TextFieldViewModelImpl();

  @override
  final SelectedListViewModel selectedListViewModel;

  SelectedListViewModelImpl get _selectedListViewModel =>
      selectedListViewModel as SelectedListViewModelImpl;

  @override
  @computed
  bool get isAddEnabled => title.text.trim().isNotEmpty && selectedListViewModel.isLoaded;

  @action
  Future<void> _addReminder() async {
    try {
      await _remindersRepository.addReminder(
        title: title.text.trim(),
        description: subTitle.text.trim().nullIfEmpty,
        listId: _selectedListViewModel.asLoaded.listId,
      );
      _router.goNamed(RouteNames.home);
    } catch (error, stackTrace) {
      log('addReminder error', error: error, stackTrace: stackTrace);
      // errorEvent = Event(error.toUiMessage());
    }
  }

  @override
  void onAddPressed() {
    _addReminder();
  }

  @override
  void onDetailsPressed() {}

  @override
  void onListPressed() {}
}
