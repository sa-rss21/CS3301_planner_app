import 'dart:math';

import 'package:cs3301_planner_app/data/notes_data.dart';
import 'package:cs3301_planner_app/pages/new_notes.dart';
import 'package:cs3301_planner_app/util/color.dart';
import 'package:cs3301_planner_app/widget/navigation_draw_widget.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  final Notes? note; //title and content for editing notes
  const NotesPage({super.key, this.note});

  State<NotesPage> createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  List<Notes> afterSearchNotes = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.yellow.shade100,
        appBar: AppBar(
          // return to previous intent
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'MY NOTES',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        endDrawer: NavigationDrawerWidget(),
        body: Padding(
          // padding for 3 lines button
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                // search icon
                onChanged: searchText,
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search_sharp,
                    color: Colors.grey,
                  ),
                  filled: false,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent)),

                  // to make the bottom line dissapear
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  fillColor: Colors.amber,
                ),
              ),
              // adding notes sections
              Expanded(
                child: ListView.builder(
                  itemCount: afterSearchNotes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      color: getRandomColor(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        // editable notes
                        onTap: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NewNotesPage(
                                        note: afterSearchNotes[index],
                                      )));
                          if (result != null) {
                            setState(() {
                              int originalIndex =
                                  notes.indexOf(afterSearchNotes[index]);
                              notes[originalIndex] = (Notes(
                                  id: notes.length,
                                  title: result[0],
                                  content: result[1]));
                              afterSearchNotes = notes;
                            });
                          }
                        },
                        // using Rich Text cause it allows displaying a list of text
                        title: RichText(
                          maxLines: null,
                          overflow: TextOverflow.ellipsis, //show ... at the end
                          text: TextSpan(
                            text: '${notes[index].title}\n',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: '${notes[index].content}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              )
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            // '$DateFormat()',
                            'Edit',
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.amber.shade700,
                                  icon: Icon(
                                    Icons.info,
                                    color: Colors.red.shade300,
                                  ),
                                  title: const Text(
                                    'Want to delete?',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  content: Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const SizedBox(
                                          width: 60,
                                          child: Text(
                                            'Yes',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const SizedBox(
                                          width: 60,
                                          child: Text(
                                            'No',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            if (result) {
                              deleteNote(index);
                            }
                          },
                          icon: Icon(Icons.delete_rounded),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // add button for adding new note to the list
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewNotesPage()));
            if (result != null) {
              setState(() {
                notes.add(Notes(
                    id: notes.length, title: result[0], content: result[1]));
                afterSearchNotes = notes;
              });
            }
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),

        // seperate multiple notes
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  final _controller = TextEditingController();

  // generate random color
  getRandomColor() {
    Random random = new Random();
    return backgroundColorForNotes[
        random.nextInt(backgroundColorForNotes.length)];
  }

  void searchText(String text) {
    setState(() {
      afterSearchNotes = notes
          .where((notes) =>
              notes.content.toLowerCase().contains(text.toLowerCase()) ||
              notes.title.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  // deleting the note
  void deleteNote(int index) {
    setState(() {
      afterSearchNotes.removeAt(index);
    });
  }

  @override
  void initState() {
    if (widget.note != null) {
      titleController = TextEditingController(text: widget.note!.title);
      contentController = TextEditingController(text: widget.note!.content);
    }

    super.initState();
    afterSearchNotes = notes;
  }
}
