import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'pages/task_list.dart';
import 'pages/home_page.dart';
import 'pages/task_dashboard.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main()  async {
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
      home: TaskDashboard(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),

    );
  }
}


