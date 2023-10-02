import 'dart:convert';
import './todo_item.dart';
import './new_todo_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListDetail extends StatefulWidget {
  final String todoList;

  TodoListDetail({required this.todoList});

  @override
  _TodoListDetailState createState() => _TodoListDetailState();
}

class _TodoListDetailState extends State<TodoListDetail> {
  List<TodoItem> items = [];
  TextEditingController itemsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  @override
  void dispose() {
    itemsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List: ${widget.todoList}'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      //Here is the to_do list structure
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final todoItem = items[index];
          return ListTile(
            title: Text(
              todoItem.text,
              style: TextStyle(
                decoration: todoItem.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: todoItem.isCompleted,
              onChanged: (isChecked) {
                setState(() {
                  todoItem.isCompleted = isChecked ?? false;
                  saveItems();
                });
              },
            ),
          );
        },
      ),
    //Add new item button
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Theme.of(context).primaryColor
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => NewTodoItemDialog(
              onAdd: (text) {
                final newItem = TodoItem(text: text);
                setState(() {
                  items.add(newItem);
                  saveItems();
                });
              },
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add Item'),
      ),
    );
  }

  void loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final savedItemsJson = prefs.getString(widget.todoList);

    if (savedItemsJson != null) {
      final List<dynamic> decodedItems = json.decode(savedItemsJson);
      setState(() {
        items = decodedItems
            .map((item) => TodoItem.fromMap(item))
            .toList();
      });
    }
  }

  void saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = json.encode(items.map((item) => item.toMap()).toList());
    prefs.setString(widget.todoList, itemsJson);
  }
}