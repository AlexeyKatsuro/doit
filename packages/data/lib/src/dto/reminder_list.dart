import 'package:domain/domain.dart';

class ReminderListDto extends ReminderList {
  ReminderListDto({required this.id, required super.name}) : super(id: id);

  @override
  final String id;
}
