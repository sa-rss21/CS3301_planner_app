import 'package:flutter/material.dart';
import './todo_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.mainTheme,
      home: TodoDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppTheme {
  static ThemeData mainTheme = ThemeData(
    primaryColor: Colors.brown[900], // Change the primary color
    cardColor: Colors.brown[100],
    // Define other attributes like text themes, fonts, etc.
  );

// You can define more themes if needed (e.g., dark theme).
}

