import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewNotesPage extends StatefulWidget {
  const NewNotesPage({super.key});

  State<NewNotesPage> createState() => NewNoteState();
}

class NewNoteState extends State<NewNotesPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.purple.shade100,
        appBar: AppBar(
          backgroundColor: Colors.purple.shade700,
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            children: [
              Row(
                children: [],
              ),
              Expanded(
                child: ListView(
                  children: [
                    TextField(
                      controller: titleController,
                      style: TextStyle(color: Colors.grey, fontSize: 30),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Text',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 30),
                      ),
                    ),
                    TextField(
                      controller: contentController,
                      style: TextStyle(color: Colors.grey, fontSize: 30),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type here',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.pop(context, [
            titleController.text,
            contentController.text,
          ]);
        }),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
