import 'package:cs3301_planner_app/widget/navigation_draw_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashBoardPage extends StatelessWidget {
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
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            makeDashboardItem("Budget", Icons.monetization_on_outlined),
            makeDashboardItem("Notes", Icons.note_sharp),
            makeDashboardItem("To Do List", Icons.list_alt)
          ],
        ),
      ),
    );
  }

  // TO DO: make items in dashboard
  Card makeDashboardItem(String title, IconData icon) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.yellow.shade200),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 50.0),
              Center(
                  child: Icon(
                icon,
                size: 40.0,
              )),
              SizedBox(height: 20.0),
              Center(
                child: Text(title,
                    style: TextStyle(
                        fontSize: 18.0, color: Colors.yellow.shade100)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
