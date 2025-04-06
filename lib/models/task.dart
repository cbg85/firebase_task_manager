class Task {
  final String id;
  final String name;
  final bool isCompleted;

  Task({required this.id, required this.name, required this.isCompleted});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isCompleted': isCompleted,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      isCompleted: map['isCompleted'],
    );
  }
}
