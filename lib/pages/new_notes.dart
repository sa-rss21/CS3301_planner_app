import 'package:cs3301_planner_app/data/notes_data.dart';
import 'package:flutter/material.dart';

class NewNotesPage extends StatefulWidget {
  final Notes? note;
  const NewNotesPage({
    super.key,
    this.note,
  });

  State<NewNotesPage> createState() => NewNoteState();
}

class NewNoteState extends State<NewNotesPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.note != null) {
      titleController = TextEditingController(text: widget.note!.title);
      contentController = TextEditingController(text: widget.note!.content);
    }

    super.initState();
  }

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
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontStyle: FontStyle.normal),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Text',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 30),
                      ),
                    ),
                    TextField(
                      controller: contentController,
                      style: TextStyle(color: Colors.black, fontSize: 30),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context, [
              titleController.text,
              contentController.text,
            ]);
          },
          elevation: 10,
          backgroundColor: Colors.purple.shade50,
          child: Icon(Icons.save),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
