import 'package:cs3301_planner_app/pages/dash_board_page.dart';
import 'package:cs3301_planner_app/util/mood_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mood_data.dart';
import '../util/new_task_dialog.dart';
import '../data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widget/navigation_draw_widget.dart';

// Define a Flutter StatefulWidget for the Mood Page
class MoodPage extends StatefulWidget {
  // constructor for MoodPage widget - takes optional key parameter and creates new instance of MoodPage
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

// Define the State class for the Mood Page
class _MoodPageState extends State<MoodPage> {
    // a variable to store selected mood
    String selectedMood = '';

    // controller for text field used to enter mood reasons
    TextEditingController moodReasonController = TextEditingController();
    // hive box for storing mood-related data
    final _mybox = Hive.box('mood_database');
    // instance of MoodData to manage mood-related data
    MoodData moodData = MoodData();
    // list to store mood entries
    List<MoodItem> moodEntries = [];

    @override
    void initState() {
      // initialize the MoodData and load existing mood entries
      moodData.prepareData();
      moodEntries = moodData.overallMoodList;
    super.initState();
  }

  // method to set the selected mood when emoji button is pressed
  void selectMood(String mood) {
    setState(() {
      selectedMood = mood;
    });
  }

  // method to save mood entry when the save button is pressed in dialog
  void save(String mood) {
    if (mood.isNotEmpty) {
      setState(() {
        // get current time
        DateTime now = DateTime.now();
        // get mood reason from the text field
        String moodReason = moodReasonController.text;
        String formattedTime = "${now.hour}:${now.minute}:${now.second}";

        // create new MoodItem and add it to list
        moodData.addNew(MoodItem(
            mood: mood,
            reason: moodReason,
            timestamp: formattedTime));
        // update mood entries list
        moodEntries = moodData.overallMoodList;

        if (moodEntries.isNotEmpty) {
        selectedMood = '';
      }
      // clear text field
      moodReasonController.clear();
      });

    }
  }
    // method to show a dialog for adding new mood note
    void addNewMoodNote() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('How do you feel today?'),
        children: [
          // emoji buttons for different moods
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildMoodButton('😀', 'Happy 😀'),
              buildMoodButton('😢', 'Sad 😢'),
              buildMoodButton('😎', 'Cool 😎'),
              buildMoodButton('😍', 'In Love 😍'),
            ],
            
          ),
          // text field for entering the mood reason
            TextField(
                controller: moodReasonController,
                decoration: InputDecoration(hintText: 'Why do you feel that way?'),
            ),
 
          // buttons for save and cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // pass the selected mood to save function
                  save(selectedMood); 
                  // close the dialog
                  Navigator.pop(context); 
                },
                child: Text('Save'),
              ),
              SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  // Close the dialog on Cancel
                  Navigator.pop(context); 
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // method to build a mood button with an emoji
  Widget buildMoodButton(String emoji, String moodName) {
    bool isSelected = moodName == selectedMood;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectMood(moodName);
        });
      },
      child: Text(emoji, style: TextStyle(fontSize: 35)),
      style: ElevatedButton.styleFrom(

        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        primary: isSelected ? Colors.blue : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI for the Mood Page
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Board'),
      ),
      body: Column(
        children: moodEntries.map((entry) {
          return ListTile(
            title: Text('${entry.mood} - ${entry.reason}'),
            subtitle: Text('Time: ${entry.timestamp}'),
          );
        }).toList(),
      ),
      // Floating action button for adding a new mood note
      floatingActionButton: FloatingActionButton(
        onPressed: addNewMoodNote,
        child: Icon(Icons.add),
      ),
    );
  }
}