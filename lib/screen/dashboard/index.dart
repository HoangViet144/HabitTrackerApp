import 'package:flutter/material.dart';
import 'package:habit_tracker_app/component/my_drawer.dart';
import 'package:habit_tracker_app/model/goal.dart';
import 'package:habit_tracker_app/model/index.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  void _tmp(context) {
    AppStateWidget.of(context).addGoal(Goal(dueDate: new DateTime(2000)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => _tmp(context),
            child: const Text("Text add goal"),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: AppStateScope.of(context).goalList.length,
        itemBuilder: (context, i) {
          return const Text("Goal here");
        },
      ),
      drawer: const MyDrawer(),
    );
  }
}
