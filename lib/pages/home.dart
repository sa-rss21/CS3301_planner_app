import 'package:flutter/material.dart';
import '../widget/navigation_draw_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: Text(
          'Home',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      drawer: NavigationDrawerWidget(),

    );
  }
}
