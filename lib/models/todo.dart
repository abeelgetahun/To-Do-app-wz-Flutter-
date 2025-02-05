class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  // Convert ToDo to Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'isDone': isDone,
    };
  }

  // Create ToDo from Map
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      isDone: json['isDone'],
    );
  }

  static List<ToDo> todoList() {
    return [
      ToDo(id: "01", todoText: "check Mail", isDone: true),
      ToDo(id: "02", todoText: "Buy Groceries", isDone: false),
      ToDo(id: "03", todoText: "Morning Excercise", isDone: false),
      ToDo(id: "04", todoText: "check Mail", isDone: false),
      ToDo(id: "05", todoText: "Team Meeting", isDone: false),
      ToDo(id: "06", todoText: "check import", isDone: true),
    ];
  }
}