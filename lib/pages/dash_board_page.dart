import 'package:cs3301_planner_app/widget/navigation_draw_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: Text('Dash board for now'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}
