import 'package:flutter/material.dart';
import 'task_list.dart';

class TaskDashboard extends StatefulWidget {
  const TaskDashboard({Key? key}) : super(key: key);

  @override
  _TaskDashboardState createState() => _TaskDashboardState();
}

class _TaskDashboardState extends State<TaskDashboard> {
  List<String> taskLists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Dashboard'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: taskLists.length + 1,
        itemBuilder: (context, index) {
          if (index == taskLists.length) {
            return InkWell(
              onTap: () {
                _createNewList();
              },
              child: Card(
                elevation: 3.0,
                child: Center(
                  child: Icon(Icons.add),
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                _navigateToTaskList(taskLists[index]); // Pass the task list name
              },
              child: Card(
                elevation: 3.0,
                child: Center(
                  child: Text(taskLists[index]),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _createNewList() {
    // Show a dialog to enter a new task list name
    showDialog(
      context: context,
      builder: (context) {
        String newListName = '';

        return AlertDialog(
          title: Text('Create New Task List'),
          content: TextField(
            onChanged: (value) {
              newListName = value;
            },
            decoration: InputDecoration(labelText: 'List Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newListName.isNotEmpty) {
                  setState(() {
                    taskLists.add(newListName);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToTaskList(String taskListName) {
    // Navigate to the selected Task List
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskList(taskListName: taskListName),
      ),
    );
  }
}
