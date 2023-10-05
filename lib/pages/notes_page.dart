import 'package:cs3301_planner_app/data/database.dart';
import 'package:cs3301_planner_app/pages/new_notes.dart';
import 'package:cs3301_planner_app/util/new_task_dialog.dart';
import 'package:cs3301_planner_app/widget/navigation_draw_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  State<NotesPage> createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  ToDoDatabase db = ToDoDatabase();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.yellow.shade100,
        appBar: AppBar(
          // return to previous intent
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'MY NOTES',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        endDrawer: NavigationDrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(300, 0, 16, 0),
          child: Column(
            children: [
              const TextField(
                // search icon
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: Colors.grey,
                    ),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.yellow)),
                    fillColor: Colors.orange),
              ),
              // Expanded(child: ListView())
            ],
          ),
        ),
        // add button
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewNotesPage()));
            if (result != null) {
              setState(() {});
            }
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),

        // seperate multiple notes
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  final _controller = TextEditingController();
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

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }
}
