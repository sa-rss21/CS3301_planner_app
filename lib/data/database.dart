import '../util/expense_item.dart';
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
class ExpenseDataBase
{
  //box reference
  final _mybox = Hive.box("expense_database");
  //write data
  void saveData(List<ExpenseItem> allExpense)
  {
    List<List<dynamic>> allExpensesFormatted = [];
    //convert data
    for(var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _mybox.put("ALL_EXPENSES", allExpensesFormatted);
  }
  void clear()
  {
    _mybox.clear();
  }
  //read data
  List<ExpenseItem> readData()
  {
    List saved = _mybox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < saved.length; i++)
      {
        String name = saved[i][0];
        String amount = saved[i][1];
        DateTime dateTime = saved[i][2];

        ExpenseItem expense = ExpenseItem(name: name,
            amount: amount,
            dateTime: dateTime);

        allExpenses.add(expense);
      }
    return allExpenses;
  }
}