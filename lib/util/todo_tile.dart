import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

    class ToDoTile extends StatelessWidget {
      final String taskName;
      final bool taskCompleted;
      Function(bool?)? onChanged;
      Function(BuildContext)? deleteFunction;
      ToDoTile({
        super.key,
        required this.taskName,
        required this.taskCompleted,
        required this.onChanged,
        required this.deleteFunction
      });
    
      @override
      Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
          child: Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: deleteFunction,
                borderRadius: BorderRadius.circular(12),
                icon: Icons.delete,
                  backgroundColor: Colors.red.shade400,
                ),

              ],
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  //checkbox
                   Checkbox(
                     value: taskCompleted,
                     onChanged: onChanged,
                     activeColor: Colors.white,
                     checkColor: Colors.grey[600],
                   ),

                  //task name
                  Text(
                    taskName,
                    style: TextStyle(
                        decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.amber[400],
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
          ),
        );
      }
    }
    