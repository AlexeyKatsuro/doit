import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RemindersRepository)
class RemindersRepositoryImpl extends RemindersRepository {
  RemindersRepositoryImpl(this._firestore, this._fireauth);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _fireauth;

  @override
  Future<int> allReminderCount() async {
    return (await _firestore.collection('reminders').count().get()).count;
  }

  @override
  Future<void> addReminder({required String title, String? description, String? listId}) async {
    await _firestore
        .collection('users')
        .doc(_fireauth.currentUser?.uid.requireNotNull('user'))
        .collection('reminder_list')
        .doc(listId ?? RemindersRepository.defaultListId)
        .collection('reminders')
        .add({
      'title': title,
      'description': description,
    });
  }
}
