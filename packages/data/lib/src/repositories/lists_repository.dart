import 'package:core/core.dart';
import 'package:data/src/dto/reminder_list.dart';
import 'package:data/src/utils/skip_impl.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'firebase_repository.dart';

@LazySingleton(as: ListsRepository)
class ListsRepositoryImpl extends FirebaseRepository with ListsRepository {
  ListsRepositoryImpl(super.firebaseFirestore, super.firebaseAuth);

  static const String defaultListId = 'default_list';

  @override
  Future<ReminderListDto> getDefaultReminderList() {
    return firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('reminder_list')
        .doc(ListsRepositoryImpl.defaultListId)
        .withConverter(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data().requireNotNull('data');
            final name = (data['name'] as String?).requireNotNull('name');
            return ReminderListDto(
              id: snapshot.id,
              name: name,
            );
          },
          toFirestore: skipImplementation,
        )
        .get()
        .then((value) => value.data().requireNotNull('data'));
  }

  @override
  Future<void> addList({required String name}) {
    return firebaseFirestore.collection('users').doc(userId).collection('reminder_list').add({
      'name': name,
    });
  }

  @override
  Future<void> editList({required covariant ReminderListDto list}) {
    return firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('reminder_list')
        .doc(list.id)
        .update({
      'name': list.name,
    });
  }

  @override
  Future<List<ReminderList>> getAllLists() {
    return firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('reminder_list')
        .withConverter(
          fromFirestore: (snapshot, options) {
            final data = snapshot.data().requireNotNull('data');
            final name = (data['name'] as String?).requireNotNull('name');
            return ReminderListDto(
              id: snapshot.id,
              name: name,
            );
          },
          toFirestore: skipImplementation,
        )
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList(growable: false);
    });
  }
}
