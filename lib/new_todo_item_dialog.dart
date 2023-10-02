import 'package:flutter/material.dart';

class NewTodoItemDialog extends StatelessWidget {
  final Function(String) onAdd;

  NewTodoItemDialog({required this.onAdd});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Item'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter the task'),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            final text = controller.text;
            if (text.isNotEmpty) {
              onAdd(text);
              controller.clear();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}