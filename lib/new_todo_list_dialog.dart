
import 'package:flutter/material.dart';

class NewTodoListDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create a New To-Do List'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter the list name'),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Create'),
          onPressed: () {
            Navigator.of(context).pop(controller.text);
          },
        ),
      ],
    );
  }
}