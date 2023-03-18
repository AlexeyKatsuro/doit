import 'package:domain/domain.dart';

abstract class RemindersRepository {
  Future<int> allReminderCount();

  Future<ReminderList> getDefaultReminderList();

  Future<void> addReminder({required String title, String? description, Object? listId});
}
