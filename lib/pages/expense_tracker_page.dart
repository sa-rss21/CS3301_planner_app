import 'package:cs3301_planner_app/data/expense_data.dart';
import 'package:cs3301_planner_app/pages/dash_board_page.dart';
import 'package:cs3301_planner_app/util/expense_item.dart';
import 'package:cs3301_planner_app/util/expense_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/expense_tile.dart';
import '../util/new_task_dialog.dart';
import '../data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widget/navigation_draw_widget.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  //add new expense
  void addNewExpense(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Add new Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //expense name
          TextField(
            controller: newExpenseNameController,
          ),
          //expense amount
          TextField(
            controller: newExpenseAmountController,
          ),
        ],
      ),
      actions: [
        //save
        MaterialButton(onPressed: save,
        child: Text('Save'),),
        //cancel
        MaterialButton(onPressed: cancel,
          child: Text('Cancel'),),
      ],
    )
    );
  }
  //saving
  void save(){
    ExpenseItem newExpense = ExpenseItem(name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now());
    //add expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clearController();
  }
  //cancel
  void cancel(){
    Navigator.pop(context);
    clearController();
  }
  void clearController()
  {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
        child: Icon(Icons.add),
        ),
        body: ListView(
          children: [
            //weekly summary
            ExpenseSummary(start: value.startOfWeek()),
            //expense list
            ListView.builder(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                    name: value.getAllExpenseList()[index].name,
                    amount: value.getAllExpenseList()[index].amount,
                    date: value.getAllExpenseList()[index].dateTime
                )
            ),
          ],
        )
      ),
    );
  }
}