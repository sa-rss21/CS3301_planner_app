import '../util/expense_item.dart';
import '../util/mood_item.dart';
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
class MoodDatabase {
  final _mybox = Hive.box('mood_database');

  // Save mood entries to the database
  void saveData(List<MoodItem> moodEntries) {
    List<List<dynamic>> allMoodEntriesFormatted = [];

    for (var entry in moodEntries) {
      List<dynamic> moodEntryFormatted = [
        entry.mood,
        entry.reason,
        entry.timestamp,
      ];
      allMoodEntriesFormatted.add(moodEntryFormatted);
    }

    _mybox.put('ALL_MOOD_ENTRIES', allMoodEntriesFormatted);
  }

  // Clear all mood data in the database
  void clear() {
    _mybox.clear();
  }

  // Read mood data from the database and convert it to MoodItem objects
  List<MoodItem> readData() {
    List saved = _mybox.get('ALL_MOOD_ENTRIES') ?? [];
    List<MoodItem> allMoodEntries = [];

    for (int i = 0; i < saved.length; i++) {
      String mood = saved[i][0];
      String reason = saved[i][1];
      String timestamp = saved[i][2];

      MoodItem moodItem = MoodItem(
        mood: mood,
        reason: reason,
        timestamp: timestamp,
      );

      allMoodEntries.add(moodItem);
    }

    return allMoodEntries;
  }
}