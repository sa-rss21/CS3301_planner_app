import 'package:hive/hive.dart';

class ToDoDatabase
{
  List todoList = [];
  //reference box
  final _mybox = Hive.box('mybox');

  //run method if first time opening app
  void createInitialData()
  {
    todoList = [
      ["Example Task", false]
    ];
  }
  //load the data from database
  void loadData()
  {
    todoList = _mybox.get("TODOLIST");
  }
  //update database
  void updateDatabase()
  {
    _mybox.put("TODOLIST", todoList);
  }
}