import 'package:domain/domain.dart';

abstract class RemindersRepository {
  static const String defaultListId = 'default_list';

  Future<int> allReminderCount();

  Future<ReminderList> getDefaultReminderList();

  Future<void> addReminder({required String title, String? description, String? listId});
}
