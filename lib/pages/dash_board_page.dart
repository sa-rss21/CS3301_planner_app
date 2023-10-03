import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dash board for now'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
      ),
    );
  }
}
