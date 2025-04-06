import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get reference to the user's task collection
  CollectionReference<Map<String, dynamic>> taskCollection(String uid) {
    return _firestore.collection('users').doc(uid).collection('tasks');
  }

  // Add a new task
  Future<void> addTask({
    required String uid,
    required String title,
    String? category,
    String? timeframe,
  }) async {
    await taskCollection(uid).add({
      'title': title,
      'isDone': false,
      'createdAt': Timestamp.now(),
      'category': category ?? '',
      'timeframe': timeframe ?? '',
    });
  }

  // Update task completion
  Future<void> updateTaskStatus({
    required String uid,
    required String taskId,
    required bool isDone,
  }) async {
    await taskCollection(uid).doc(taskId).update({
      'isDone': isDone,
    });
  }

  // Delete a task
  Future<void> deleteTask({
    required String uid,
    required String taskId,
  }) async {
    await taskCollection(uid).doc(taskId).delete();
  }

  // Stream all tasks
  Stream<QuerySnapshot<Map<String, dynamic>>> streamTasks(String uid) {
    return taskCollection(uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
