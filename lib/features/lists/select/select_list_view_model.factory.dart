import 'package:doit/features/lists/select/select_list_view_model.dart';
import 'package:domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:ui/ui.dart';

@injectable
class SelectListViewModelFactory {
  SelectListViewModelFactory(this._router, this._listsRepository);

  final GoRouter _router;
  final ListsRepository _listsRepository;

  SelectListViewModel create(Object selectedListId) {
    return SelectListViewModelImpl(
      _router,
      _listsRepository,
      selectedListId,
    );
  }
}
