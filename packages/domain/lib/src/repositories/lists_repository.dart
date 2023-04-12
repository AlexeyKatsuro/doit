import 'package:domain/domain.dart';

abstract class ListsRepository {
  Future<List<ReminderList>> getAllLists();

  Future<List<CountOf<ReminderList>>> getAllListsWithCount();

  Future<ReminderList> getDefaultReminderList();

  Future<void> addList({required String name});

  Future<void> editList({required ReminderList list});
}
