import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TaskService _taskService = TaskService();

  void _addTask() {
    Task newTask = Task(id: FirebaseFirestore.instance.collection('tasks').doc().id, name: _taskController.text);
    _taskService.addTask(newTask);
    _taskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Task Manager")),
      body: Column(
        children: [
          TextField(controller: _taskController, decoration: InputDecoration(labelText: "Enter Task")),
          ElevatedButton(onPressed: _addTask, child: Text("Add Task")),
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: _taskService.getTasks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView(
                  children: snapshot.data!.map((task) {
                    return ListTile(
                      title: Text(task.name),
                      trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => _taskService.deleteTask(task.id)),
                      leading: Checkbox(value: task.isCompleted, onChanged: (value) {
                        task.isCompleted = value!;
                        _taskService.updateTask(task);
                      }),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
