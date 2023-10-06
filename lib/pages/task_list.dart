import 'package:cs3301_planner_app/pages/dash_board_page.dart';
import 'package:flutter/material.dart';
import '../util/todo_tile.dart';
import '../util/new_task_dialog.dart';
import '../data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widget/navigation_draw_widget.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _mybox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if first time opening app, create default data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();
  //list of todo tasks

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: saveNewTask,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void handleClicked(int item) {
    switch (item) {
      case 0:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          // return to previous intent
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'TO DO',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),

          // menu button to open sideBar
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(Icons.menu_outlined));
            })
          ],
          centerTitle: true,
          elevation: 10,
          backgroundColor: Colors
              .transparent, // Set the AppBar background color to transparent
          automaticallyImplyLeading: false, // Disable the back button if needed
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(
                    20.0), // Adjust the radius to round the corners as desired
              ),
              color: Colors.amber, // You can set the background color here
            ),
          ),
        ),
        // drawer: NavigationDrawerWidget(),

        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
