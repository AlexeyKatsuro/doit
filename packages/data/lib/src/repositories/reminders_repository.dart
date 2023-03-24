import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'firebase_repository.dart';
import 'lists_repository.dart';

@LazySingleton(as: RemindersRepository)
class RemindersRepositoryImpl extends FirebaseRepository with RemindersRepository {
  RemindersRepositoryImpl(super.firebaseFirestore, super.firebaseAuth);

  @override
  Future<int> allReminderCount() async {
    return (await firebaseFirestore.collection('reminders').count().get()).count;
  }

  @override
  Future<void> addReminder(
      {required String title, String? description, covariant String? listId}) async {
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('reminder_list')
        .doc(listId ?? ListsRepositoryImpl.defaultListId)
        .collection('reminders')
        .add({
      'title': title,
      'description': description,
    });
  }
}
