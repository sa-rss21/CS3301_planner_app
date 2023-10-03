import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../util/todo_tile.dart';
import '../util/new_task_dialog.dart';
import '../data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskList extends StatefulWidget {
  final String taskListName;

  TaskList({Key? key, required this.taskListName}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _mybox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if first time opening app, create default data
    if(_mybox.get("TODOLIST") == null)
    {
      db.createInitialData();
    }
    else
    {
      db.loadData();
    }
    super.initState();
  }
  //text controller
  final _controller = TextEditingController();
  //list of todo tasks

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
      if (value == true)
      {
         moveTaskToBottom(index);
      }

    });

    db.updateDatabase();
  }
  void saveNewTask()
  {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }
  void createNewTask()
  {
    showDialog(context: context, builder: (context)
    {
      return DialogBox(
        controller: _controller,
        onCancel: () => Navigator.of(context).pop(),
        onSave: saveNewTask,
      );
    });
  }
  void moveTaskToBottom(int index)
  {
    setState(() {
      final tile = db.todoList.removeAt(index);
      db.todoList.insert(db.todoList.length , tile);
    });
    db.updateDatabase();
  }
  void deleteTask(int index)
  {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: Colors.amber[100],

      appBar: AppBar(
        title: Text('TO DO'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the TaskDashboard
              Navigator.pop(context);
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),

          );
        },

    ),

    );
  }
}