


class TodoItem {
  String text;
  bool isCompleted;

  TodoItem({required this.text, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isCompleted': isCompleted,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      text: map['text'],
      isCompleted: map['isCompleted'],
    );
  }
}