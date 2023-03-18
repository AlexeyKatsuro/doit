import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'firebase_repository.dart';

@LazySingleton(as: RemindersRepository)
class RemindersRepositoryImpl extends FirebaseRepository with RemindersRepository {
  RemindersRepositoryImpl(super.firebaseFirestore, super.firebaseAuth);

  static const String defaultListId = 'default_list';

  @override
  Future<int> allReminderCount() async {
    return (await firebaseFirestore.collection('reminders').count().get()).count;
  }

  @override
  Future<void> addReminder({required String title, String? description, Object? listId}) async {
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('reminder_list')
        .doc(listId as String? ?? RemindersRepositoryImpl.defaultListId)
        .collection('reminders')
        .add({
      'title': title,
      'description': description,
    });
  }

  @override
  Future<ReminderList> getDefaultReminderList() {
    return firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('reminder_list')
        .doc(RemindersRepositoryImpl.defaultListId)
        .withConverter(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data().requireNotNull('data');
            final name = (data['name'] as String?).requireNotNull('name');
            return ReminderList(
              id: snapshot.id,
              name: name,
            );
          },
          toFirestore: (value, options) => throw UnimplementedError(),
        )
        .get()
        .then((value) => value.data().requireNotNull('data'));
  }
}
