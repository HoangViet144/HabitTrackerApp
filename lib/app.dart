import 'package:flutter/material.dart';

import 'package:habit_tracker_app/screen/login/index.dart' show LoginScreen;

class HabitTrackerApp extends StatefulWidget {
  const HabitTrackerApp({Key? key}) : super(key: key);

  @override
  _HabitTrackerAppState createState() => _HabitTrackerAppState();
}

class _HabitTrackerAppState extends State<HabitTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker App',
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginScreen(),
      },
    );
  }
}
