import 'package:cs3301_planner_app/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bargraph/bar_graph.dart';
class ExpenseSummary extends StatelessWidget {
  final DateTime? start;
  const ExpenseSummary({super.key, required this.start});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, children) => SizedBox(
        height: 200,
        child: MyBarGraph(
            maxY: 100,
            sunAmount: 20,
            monAmount: 50,
            tueAmount: 10,
            wedAmount: 30,
            thurAmount: 100,
            friAmount: 90,
            satAmount: 15
        ),
      )
    );
  }
}
