import 'package:cs3301_planner_app/pages/dash_board_page.dart';
import 'package:cs3301_planner_app/util/mood_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mood_data.dart';
import '../util/new_task_dialog.dart';
import '../data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widget/navigation_draw_widget.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
    String selectedMood = '';

    TextEditingController moodReasonController = TextEditingController();
    final _mybox = Hive.box('mood_database');
    MoodData moodData = MoodData();
    List<MoodItem> moodEntries = [];

    @override
    void initState() {
    // TODO: implement initState
      moodData.prepareData();
      moodEntries = moodData.overallMoodList;
    super.initState();
  }

  void selectMood(String mood) {
    setState(() {
      selectedMood = mood;
    });
  }
  void save(String mood) {
    if (mood.isNotEmpty) {
      setState(() {
        // Get the current time
        DateTime now = DateTime.now();
        String moodReason = moodReasonController.text; // Get mood reason from the text field
        String formattedTime = "${now.hour}:${now.minute}:${now.second}";

        moodData.addNew(MoodItem(
            mood: mood,
            reason: moodReason,
            timestamp: formattedTime));
        moodEntries = moodData.overallMoodList;

        if (moodEntries.isNotEmpty) {
        selectedMood = '';
      }
      moodReasonController.clear();
      });

    }
  }

    void addNewMoodNote() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('How do you feel today?'),
        children: [
          // Emoji buttons for different moods
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildMoodButton('😀', 'Happy 😀'),
              buildMoodButton('😢', 'Sad 😢'),
              buildMoodButton('😎', 'Cool 😎'),
              buildMoodButton('😍', 'In Love 😍'),
            ],
            
          ),
          // Text field for entering the mood reason
            TextField(
                controller: moodReasonController,
                decoration: InputDecoration(hintText: 'Why do you feel that way?'),
            ),
 
          // Buttons for Save and Cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  save(selectedMood); // Pass the selected mood to save function
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Save'),
              ),
              SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog on Cancel
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
   Widget buildMoodButton(String emoji, String moodName) {
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: addNewMoodNote,
        child: Icon(Icons.add),
      ),
    );
  }
}