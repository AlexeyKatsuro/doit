import 'dart:developer';

import 'package:core/core.dart';
import 'package:doit/features/common/index.dart';
import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

import '../navigation/router.dart';

part 'new_reminder_view_model.g.dart';

@Injectable(as: NewReminderViewModel)
class NewReminderViewModelImpl = NewReminderViewModelBase with _$NewReminderViewModelImpl;

abstract class NewReminderViewModelBase with Store implements NewReminderViewModel {
  NewReminderViewModelBase(this._remindersRepository, this._router);

  final RemindersRepository _remindersRepository;
  final GoRouter _router;

  @observable
  Event<UiMessage?> errorEvent = Event(null);

  @override
  @observable
  TextFieldViewModel title = TextFieldViewModelImpl();

  @override
  @observable
  TextFieldViewModel subTitle = TextFieldViewModelImpl();

  @override
  @observable
  String selectedListName = 'Reminders';

  @override
  @computed
  bool get isAddEnabled => title.text.trim().isNotEmpty;

  @action
  Future<void> _addReminder() async {
    try {
      await _remindersRepository.addReminder(
        title: title.text.trim(),
        description: subTitle.text.trim().nullIfEmpty,
      );
      _router.goNamed(RouteNames.home);
    } catch (error, stackTrace) {
      log('addReminder error', error: error, stackTrace: stackTrace);
      errorEvent = Event(error.toUiMessage());
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
