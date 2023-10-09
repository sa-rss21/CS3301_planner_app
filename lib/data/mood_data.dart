
import 'package:cs3301_planner_app/data/database.dart';
import 'package:flutter/cupertino.dart';

import '../util/mood_item.dart';

class MoodData extends ChangeNotifier{

  //list of ALL expenses
  List<MoodItem> overallMoodList = [];
  //get expense list

  final db = MoodDatabase();
  //prepare data
  void prepareData()
  {

    if(db.readData().isNotEmpty){
      overallMoodList = db.readData();
    }
  }
  //add new expense
  void addNew(MoodItem newExpense)
  {
    overallMoodList.add(newExpense);
    db.saveData(overallMoodList);
    notifyListeners();
  }
  //delete expense
  void delete(MoodItem mood)
  {
    overallMoodList.remove(mood);
    db.saveData(overallMoodList);
    notifyListeners();
  }
}