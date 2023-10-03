import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main()  async {
  //initialize the hive memory saving
  Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('mybox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}


