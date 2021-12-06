import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/app_state.dart' show AppState;
import 'package:habit_tracker_app/model/goal.dart' show Goal;

class AppStateScope extends InheritedWidget {
  const AppStateScope(this.data, {Key? key, required Widget child})
      : super(key: key, child: child);

  final AppState data;

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return data != oldWidget.data;
  }
}

class AppStateWidget extends StatefulWidget {
  AppStateWidget({required this.child});

  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  AppStateWidgetState createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  AppState _data = AppState();

  void setGoalList(List<Goal> newGoalList) {
    if (newGoalList != _data.goalList) {
      setState(() {
        _data = _data.copyWith(
          goalsList: newGoalList,
        );
      });
    }
  }

  List<Goal> getGoalList() {
    return _data.goalList;
  }

  void addGoal(Goal newGoal) {
    // TODO
  }

  void removeGoal(int id) {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      _data,
      child: widget.child,
    );
  }
}
