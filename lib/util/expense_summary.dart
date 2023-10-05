import 'package:cs3301_planner_app/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bargraph/bar_graph.dart';
import '../datetime/date_time_helper.dart';
class ExpenseSummary extends StatelessWidget {
  final DateTime? start;
  const ExpenseSummary({super.key, required this.start});

  @override
  Widget build(BuildContext context) {
    String sunday = convert(start!.add(Duration(days : 0)));
    String monday = convert(start!.add(Duration(days : 1)));
    String tuesday = convert(start!.add(Duration(days : 2)));
    String wednesday = convert(start!.add(Duration(days : 3)));
    String thursday = convert(start!.add(Duration(days : 4)));
    String friday = convert(start!.add(Duration(days : 5)));
    String saturday = convert(start!.add(Duration(days : 6)));
    return Consumer<ExpenseData>(
      builder: (context, value, children) => SizedBox(
        height: 200,
        child: MyBarGraph(
            maxY: 100,
            sunAmount: value.calculateDailySummary()[sunday] ?? 0,
            monAmount: value.calculateDailySummary()[monday] ?? 0,
            tueAmount: value.calculateDailySummary()[tuesday] ?? 0,
            wedAmount: value.calculateDailySummary()[wednesday] ?? 0,
            thurAmount: value.calculateDailySummary()[thursday] ?? 0,
            friAmount: value.calculateDailySummary()[friday] ?? 0,
            satAmount: value.calculateDailySummary()[saturday] ?? 0
        ),
      )
    );
  }
}
