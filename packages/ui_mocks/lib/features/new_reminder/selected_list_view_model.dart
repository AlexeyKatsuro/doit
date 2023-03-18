import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

class SelectedListViewModelMock extends SelectedListViewModel {
  const SelectedListViewModelMock(this.state);

  const SelectedListViewModelMock.loaded([
    SelectedListLoadedViewModelMock this.state = const SelectedListLoadedViewModelMock(),
  ]);

  const SelectedListViewModelMock.loading([
    SelectedListLoadingViewModelMock this.state = const SelectedListLoadingViewModelMock(),
  ]);

  const SelectedListViewModelMock.error([
    SelectedListErrorViewModelMock this.state =
        const SelectedListErrorViewModelMock(errorMessage: UiMessage.text('Something went wrong')),
  ]);

  @override
  final Object state;
}

class SelectedListLoadedViewModelMock extends SelectedListLoadedViewModel with MockCallbacks {
  const SelectedListLoadedViewModelMock({
    this.selectedListName = const UiMessage.text('Reminders'),
  });

  @override
  final UiMessage selectedListName;
}

class SelectedListErrorViewModelMock extends SelectedListErrorViewModel with MockCallbacks {
  const SelectedListErrorViewModelMock({
    required this.errorMessage,
  });

  @override
  final UiMessage errorMessage;
}

class SelectedListLoadingViewModelMock extends SelectedListLoadingViewModel {
  const SelectedListLoadingViewModelMock();
}
