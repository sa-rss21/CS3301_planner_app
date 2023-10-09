import 'package:cs3301_planner_app/pages/expense_tracker_page.dart';
import 'package:cs3301_planner_app/pages/notes_page.dart';
import 'package:cs3301_planner_app/pages/mood_tracker_page.dart';
import 'package:cs3301_planner_app/pages/task_list.dart';
import 'package:cs3301_planner_app/widget/navigation_draw_widget.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  var images = [
    "assets/images/book.png",
    "assets/images/shopping-cart.png",
    "assets/images/to-do-list.png",
    "assets/images/emotion.png"
  ];

  var services = [
    "Notes",
    "Expenses",
    "To Do List",
    "Mood"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Resource Dash Board'),
        centerTitle: true,
        backgroundColor: Colors.amber.shade400,
      ),
      endDrawer: NavigationDrawerWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
        // display grids
        // child: InkWell(
        //   onTap: () {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => TaskList()));
        //   },
        //   child: GridView.builder(
        //       itemCount: services.length,
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           childAspectRatio: MediaQuery.of(context).size.width /
        //               (MediaQuery.of(context).size.height / 2.0)),
        //       itemBuilder: (BuildContext context, int index) {
        //         return Card(
        //           child: Column(
        //             children: <Widget>[
        //               SizedBox(height: 40),
        //               // Image(image: new AssetImage(images[index])),
        //               Image.asset(images[index], height: 120, width: 100),
        //               Padding(
        //                   padding: const EdgeInsets.all(10),
        //                   child: Text(services[index],
        //                       style: TextStyle(
        //                           fontSize: 24,
        //                           height: 1.2,
        //                           fontWeight: FontWeight.bold),
        //                       textAlign: TextAlign.left))
        //             ],
        //           ),
        //         );
        //       }),
        // ),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
          children: [
            // NOTES
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NotesPage()));
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    // Image(image: new AssetImage(images[index])),
                    Image.asset(images[0], height: 100, width: 100),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(services[0],
                            style: TextStyle(
                                fontSize: 24,
                                height: 1.2,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(12)),
            ),
            // EXPENSE TRACKER
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExpensePage()));
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    // Image(image: new AssetImage(images[index])),
                    Image.asset(images[1], height: 100, width: 100),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(services[1],
                            style: TextStyle(
                                fontSize: 24,
                                height: 1.2,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.amber[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // TO DO LIST
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TaskList()));
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    // Image(image: new AssetImage(images[index])),
                    Image.asset(images[2], height: 100, width: 100),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(services[2],
                            style: TextStyle(
                                fontSize: 24,
                                height: 1.2,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.amber[300],
                
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
            // MOOD TRACKER
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MoodPage()));
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    // Image(image: new AssetImage(images[index])),
                    Image.asset(images[3], height: 120, width: 100),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(services[3],
                            style: TextStyle(
                                fontSize: 24,
                                height: 1.2,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left))
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(12),
              ),

            )
          ],
        ),
      ),
    );
  }
}
