import 'package:doit_ui_mocks/features/common/index.dart';
import 'package:ui/ui.dart';

class SelectListViewModelMock extends SelectListViewModel with MockCallbacks {
  const SelectListViewModelMock({required this.lists});

  @override
  final Async<List<ListViewModel>> lists;
}
