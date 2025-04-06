import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TaskService _taskService = TaskService();
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  void _addTask() {
    if (_currentUser == null) return;

    final newTask = Task(
      id: FirebaseFirestore.instance.collection('tasks').doc().id,
      name: _taskController.text,
      isCompleted: false,
    );

    _taskService.addTask(_currentUser!.uid, newTask);
    _taskController.clear();
  }

  void _toggleComplete(Task task, bool? value) {
    if (_currentUser == null) return;

    _taskService.updateTask(_currentUser!.uid, task.id, {
      'isCompleted': value ?? false,
    });
  }

  void _deleteTask(String taskId) {
    if (_currentUser == null) return;

    _taskService.deleteTask(_currentUser!.uid, taskId);
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return Scaffold(
        body: Center(child: Text("Please log in.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Firebase Task Manager")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: "Enter Task"),
            ),
          ),
          ElevatedButton(onPressed: _addTask, child: Text("Add Task")),
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: _taskService.getTasks(_currentUser!.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                final tasks = snapshot.data!;
                if (tasks.isEmpty) {
                  return Center(child: Text("No tasks found."));
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task.name),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTask(task.id),
                      ),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) => _toggleComplete(task, value),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
