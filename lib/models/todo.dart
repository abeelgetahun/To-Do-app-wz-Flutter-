class ToDo {
  final String id;
  final String todoText;
  final bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  /// Convert ToDo to Map (for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'isDone': isDone,
    };
  }

  /// Create ToDo from Map (JSON deserialization)
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'] ?? '',
      todoText: json['todoText'] ?? '',
      isDone: json['isDone'] ?? false,
    );
  }

  /// Creates a copy of the current ToDo with updated fields
  ToDo copyWith({String? id, String? todoText, bool? isDone}) {
    return ToDo(
      id: id ?? this.id,
      todoText: todoText ?? this.todoText,
      isDone: isDone ?? this.isDone,
    );
  }

  /// Sample ToDo List
  static List<ToDo> sampleList() {
    return [
      ToDo(id: "01", todoText: "Check Mail", isDone: true),
      ToDo(id: "02", todoText: "Buy Groceries"),
      ToDo(id: "03", todoText: "Morning Exercise"),
      ToDo(id: "04", todoText: "Check Mail"),
      ToDo(id: "05", todoText: "Team Meeting"),
      ToDo(id: "06", todoText: "Check Import", isDone: true),
    ];
  }
}
