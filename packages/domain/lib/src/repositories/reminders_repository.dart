abstract class RemindersRepository {
  Future<int> allReminderCount();

  Future<void> addReminder({required String title, String? description, Object? listId});
}
