import 'package:cs3301_planner_app/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bargraph/bar_graph.dart';
import '../datetime/date_time_helper.dart';
class ExpenseSummary extends StatelessWidget {
  final DateTime? start;
  const ExpenseSummary({super.key, required this.start});

  double calcMax(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday)
  {
    double? max = 100;
    List<double> values = [
      value.calculateDailySummary()[sunday] ?? 0,
      value.calculateDailySummary()[monday] ?? 0,
      value.calculateDailySummary()[tuesday] ?? 0,
      value.calculateDailySummary()[wednesday] ?? 0,
      value.calculateDailySummary()[thursday] ?? 0,
      value.calculateDailySummary()[friday] ?? 0,
      value.calculateDailySummary()[saturday] ?? 0,

    ];

    values.sort();
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }
  String calcWeekTotal(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday)
  {
    List<double> values = [
      value.calculateDailySummary()[sunday] ?? 0,
      value.calculateDailySummary()[monday] ?? 0,
      value.calculateDailySummary()[tuesday] ?? 0,
      value.calculateDailySummary()[wednesday] ?? 0,
      value.calculateDailySummary()[thursday] ?? 0,
      value.calculateDailySummary()[friday] ?? 0,
      value.calculateDailySummary()[saturday] ?? 0,

    ];
    double total = 0;
    for (int i = 0; i < values.length; i++ ){
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }
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
      builder: (context, value, children) => Column(

        children: [
          Padding(padding: const EdgeInsets.all(25),
          //weeks total
          child: Row(
            children: [
              const Text('Weeks Total:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('\$${calcWeekTotal(value, sunday, monday, tuesday,
                  wednesday, thursday, friday, saturday)}'),
            ],
          ),
    ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
                maxY: calcMax(value, sunday, monday, tuesday,
                    wednesday, thursday, friday, saturday),
                sunAmount: value.calculateDailySummary()[sunday] ?? 0,
                monAmount: value.calculateDailySummary()[monday] ?? 0,
                tueAmount: value.calculateDailySummary()[tuesday] ?? 0,
                wedAmount: value.calculateDailySummary()[wednesday] ?? 0,
                thurAmount: value.calculateDailySummary()[thursday] ?? 0,
                friAmount: value.calculateDailySummary()[friday] ?? 0,
                satAmount: value.calculateDailySummary()[saturday] ?? 0
            ),
          ),
        ],
      )
    );
  }
}
