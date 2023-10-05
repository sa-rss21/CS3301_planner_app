import 'package:cs3301_planner_app/pages/notes_page.dart';
import 'package:cs3301_planner_app/pages/task_list.dart';
import 'package:cs3301_planner_app/widget/navigation_draw_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashBoardPage extends StatelessWidget {
  var images = [
    "assets/images/book.png",
    "assets/images/shopping-cart.png",
    "assets/images/to-do-list.png",
  ];

  var services = [
    "Notes",
    "Expenses",
    "To Do List",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        title: Text('Dash board for now'),
        centerTitle: true,
        backgroundColor: Colors.amber.shade400,
      ),
      endDrawer: NavigationDrawerWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
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
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            // NOTES
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotesPage()));
              },
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  // Image(image: new AssetImage(images[index])),
                  Image.asset(images[0], height: 120, width: 100),
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
            // EXPENSE TRACKER
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TaskList()));
              },
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  // Image(image: new AssetImage(images[index])),
                  Image.asset(images[1], height: 120, width: 100),
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
            // TO DO LIST
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TaskList()));
              },
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  // Image(image: new AssetImage(images[index])),
                  Image.asset(images[2], height: 120, width: 100),
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
            )
          ],
        ),
      ),
    );
  }
}
