import 'package:flutter/material.dart';
import '../util/my_button.dart';

    class DialogBox extends StatelessWidget {
      final controller;
      VoidCallback onSave;
      VoidCallback onCancel;
      DialogBox({
        super.key,
        required this.controller,
        required this.onCancel,
        required this.onSave});

      @override
      Widget build(BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.amber[100],
          content: Container(height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //get user input
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a new task",
                ),
              ),
              //buttons save and cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //save
                  MyButton(text: "save", onPressed: onSave),
                  const SizedBox(width: 10,),
                  //cancel button
                  MyButton(text: "cancel", onPressed: onCancel)
                ],
              )
            ],
          ),),


        );
      }
    }
