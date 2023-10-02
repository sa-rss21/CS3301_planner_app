import './todo_list.dart';
import './new_todo_list_dialog.dart';
import 'package:flutter/material.dart';

class TodoDashboard extends StatefulWidget {
  @override
  _TodoDashboardState createState() => _TodoDashboardState();
}

class _TodoDashboardState extends State<TodoDashboard> {
  List<String> todoLists = [];

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = (MediaQuery.of(context).size.width / 200).floor();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Todo Dashboard'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        itemCount: todoLists.length,
        itemBuilder: (context, index) {
          final todoList = todoLists[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoListDetail(todoList: todoList),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text(todoList),
              ),
              color: Theme.of(context).cardColor,
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Theme.of(context).primaryColor

        ),

        onPressed: () async {
          final newTodoList = await showDialog(
            context: context,
            builder: (context) => NewTodoListDialog(),
          );
          if (newTodoList != null) {
            setState(() {
              todoLists.add(newTodoList);
            });
          }
        },
        icon: Icon(Icons.add),
        label: Text('Add List'),
      ),
    );
  }
}