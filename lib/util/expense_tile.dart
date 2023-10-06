import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime date;
  void Function(BuildContext)? onPressed;
  ExpenseTile({super.key,
    required this.name,
    required this.amount,
    required this.onPressed,
    required this.date,});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          //delete button
          SlidableAction(onPressed: onPressed,
          icon: Icons.delete,
          backgroundColor: Colors.red,
          )

        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text('${date.day} / ${date.month} / ${date.year}'
        ),
        trailing: Text('\$'  + amount),
      ),
    );
  }


}
