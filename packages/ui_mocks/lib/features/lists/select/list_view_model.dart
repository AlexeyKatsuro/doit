import 'package:doit_ui_mocks/features/common/mock_callbacks.dart';
import 'package:localization/localization.dart';
import 'package:ui/ui.dart';

class ListViewModelMock extends ListViewModel with MockCallbacks {
  const ListViewModelMock({
    required this.icon,
    required this.name,
    required this.isSelected,
  });

  @override
  final IconType icon;

  @override
  final UiMessage name;

  @override
  final bool isSelected;
}
