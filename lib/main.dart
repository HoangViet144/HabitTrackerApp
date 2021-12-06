import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:habit_tracker_app/app.dart' show HabitTrackerApp;
import 'package:habit_tracker_app/screen/welcome/index.dart' show WelcomeScreen;
import 'package:habit_tracker_app/model/index.dart' show AppStateWidget;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BeforeApp());
}

class BeforeApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  BeforeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: _initialization,
      future: Future.delayed(Duration(seconds: 5)),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const WelcomeScreen();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AppStateWidget(
            child: const HabitTrackerApp(),
          );
        }
        return const WelcomeScreen();
      },
    );
  }
}
