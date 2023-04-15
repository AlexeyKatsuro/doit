import 'package:ui/src/common/index.dart';
import 'package:ui/src/utils/async.dart';

import 'widgets/list_view_model.dart';

abstract class SelectListViewModel extends ViewModel {
  const SelectListViewModel();

  Async<List<ListViewModel>> get lists;
}
