abstract class RemindersRepository {
  static const String defaultListId = 'default_list';

  Future<int> allReminderCount();

  Future<void> addReminder({required String title, String? description, String? listId});
}
