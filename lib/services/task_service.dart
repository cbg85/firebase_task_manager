import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final CollectionReference _tasksCollection =
  FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(String uid, Map<String, dynamic> taskData) {
    return _tasksCollection.doc(uid).collection('userTasks').add(taskData);
  }

  Stream<QuerySnapshot> getTasks(String uid) {
    return _tasksCollection.doc(uid).collection('userTasks').snapshots();
  }

  Future<void> updateTask(String uid, String taskId, Map<String, dynamic> updatedData) {
    return _tasksCollection.doc(uid).collection('userTasks').doc(taskId).update(updatedData);
  }

  Future<void> deleteTask(String uid, String taskId) {
    return _tasksCollection.doc(uid).collection('userTasks').doc(taskId).delete();
  }
}
