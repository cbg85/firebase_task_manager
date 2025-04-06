class Task {
  String id;
  String name;
  bool isCompleted;
  List<Task> subTasks; // Nested list

  Task({required this.id, required this.name, this.isCompleted = false, this.subTasks = const []});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isCompleted': isCompleted,
      'subTasks': subTasks.map((task) => task.toMap()).toList(),
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      isCompleted: map['isCompleted'],
      subTasks: List<Task>.from(map['subTasks']?.map((task) => Task.fromMap(task)) ?? []),
    );
  }
}
