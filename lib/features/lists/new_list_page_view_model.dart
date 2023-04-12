import 'dart:developer';

import 'package:doit/features/common/index.dart';
import 'package:doit/features/navigation/router.dart';
import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:ui/ui.dart';

part 'new_list_page_view_model.g.dart';

@Injectable(as: NewListPageViewModel)
class NewListPageViewModelImpl extends NewListPageViewModelBase with _$NewListPageViewModelImpl {
  NewListPageViewModelImpl(super.listsRepository, super.router);

  @override
  @postConstruct
  void init() => super.init();
}

abstract class NewListPageViewModelBase extends NewListPageViewModel with Store, RunAsync {
  NewListPageViewModelBase(this._listsRepository, this._router);

  final ListsRepository _listsRepository;
  final GoRouter _router;

  @override
  // TODO l10n
  UiMessage get title => const UiMessage.text('New List');

  @override
  late final Async<TextFieldViewModel> listNameField = completeAsync(TextFieldViewModelImpl());

  @override
  @computed
  bool get isSubmitEnabled => super.isSubmitEnabled;

  @override
  @observable
  Upload submitStatus = const Upload.idle();

  @action
  Future<void> _saveList({required String name}) async {
    try {
      submitStatus = const Upload.loading();
      await _listsRepository.addList(name: name);
      submitStatus = const Upload.done();
    } catch (error, stackTrace) {
      log('error of addList', error: error, stackTrace: stackTrace);
      submitStatus = Upload.error(error.toUiMessage());
    }
  }

  @override
  void onSubmitPressed() {
    if (submitStatus.isLoading) return;
    listNameField.whenOrNull(
      loaded: (nameField) async {
        await _saveList(name: nameField.text);
        _router.goNamed(RouteNames.home);
      },
    );
  }
}
