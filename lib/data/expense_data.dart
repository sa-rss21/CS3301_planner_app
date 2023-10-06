
import 'package:cs3301_planner_app/data/database.dart';
import 'package:flutter/cupertino.dart';
import '../util/expense_item.dart';
import '../datetime/date_time_helper.dart';

class ExpenseData extends ChangeNotifier{

  //list of ALL expenses
  List<ExpenseItem> overallExpenseList = [];
  //get expense list
  List<ExpenseItem> getAllExpenseList()
  {
    return overallExpenseList;
  }
  final db = ExpenseDataBase();
  //prepare data
  void prepareData()
  {
  
    if(db.readData().isNotEmpty){
      overallExpenseList = db.readData();
    }
  }
  //add new expense
  void addNewExpense(ExpenseItem newExpense)
  {
    overallExpenseList.add(newExpense);
    db.saveData(overallExpenseList);
    notifyListeners();
  }
  //delete expense
  void deleteExpense(ExpenseItem ex)
  {
    overallExpenseList.remove(ex);
    db.saveData(overallExpenseList);
    notifyListeners();
  }
  //get weekday (mon tues etc)
  String getDayName(DateTime time)
  {
    switch (time.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //get date for start of week ( sunday )
  DateTime? startOfWeek()
  {
    DateTime? start;

    DateTime today = DateTime.now();

    for(int i = 0; i < 7; i++){
      if(getDayName(today.subtract(Duration(days:i))) == 'Sun'){
        start = today.subtract(Duration(days:i));
      }
    }
    return start;
  }

  Map<String, double> calculateDailySummary(){
    Map<String, double> dailySummary = {
      // date yyyymmdd : ammount total

    };
    for (var expense in overallExpenseList){
      String date = convert(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailySummary.containsKey(date)){
        double curr = dailySummary[date]!;
        curr += amount;
        dailySummary[date] = curr;
      }else{
        dailySummary.addAll({date : amount});
      }
    }
    return dailySummary;
  }
}