import 'package:cs3301_planner_app/pages/dash_board_page.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  //initialize the hive memory saving
  Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  //open a box
  var box = await Hive.openBox('mybox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashBoardPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
    );
  }
}
