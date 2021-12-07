import 'package:flutter/material.dart';
import 'package:habit_tracker_app/screen/goal/goal_add/index.dart';

import 'package:habit_tracker_app/screen/login/index.dart' show LoginScreen;
import 'package:habit_tracker_app/constant/theme.dart' show theme;
import 'package:habit_tracker_app/screen/dashboard/index.dart'
    show DashBoardScreen;

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
      initialRoute: '/create-goal',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginScreen(),
        '/dashboard': (BuildContext context) => const DashBoardScreen(),
        '/achivements': (BuildContext context) => const DashBoardScreen(),
        '/create-goal': (BuildContext context) => const AddGoalScreen()
      },
      theme: theme,
    );
  }
}
