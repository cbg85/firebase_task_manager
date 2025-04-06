import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTask(String uid, Task task) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(task.id)
        .set(task.toMap());
  }

  Stream<List<Task>> getTasks(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }

  Future<void> updateTask(String uid, String taskId, Map<String, dynamic> data) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(taskId)
        .update(data);
  }

  Future<void> deleteTask(String uid, String taskId) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}

