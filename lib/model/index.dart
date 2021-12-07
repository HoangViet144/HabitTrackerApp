import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/app_state.dart' show AppState;
import 'package:habit_tracker_app/model/goal.dart' show Goal;
import 'package:habit_tracker_app/service/storage.dart';
import 'package:uuid/uuid.dart';

final GlobalKey<AppStateWidgetState> appState =
    GlobalKey<AppStateWidgetState>();

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
    var uuid = Uuid();

    String id = uuid.v1();
    newGoal = newGoal.copyWith(id: id);
    setState(() {
      _data = _data.copyWith(goalsList: _data.goalList + [newGoal]);
      storeGoalList(_data.goalList);
    });

    addGoalRemote(newGoal);
  }

  void removeGoal(String id) {
    setState(() {
      List<Goal> curGoal = List<Goal>.from(_data.goalList);
      curGoal.removeWhere((element) => element.id == id);
      _data = _data.copyWith(goalsList: curGoal);

      storeGoalList(_data.goalList);
      removeGoalRemote(id);
    });
  }

  void updateGoal(Goal goal) {
    setState(() {
      List<Goal> curGoal = List<Goal>.from(_data.goalList);
      curGoal[curGoal.indexWhere((element) => element.id == goal.id)] = goal;
      _data = _data.copyWith(goalsList: curGoal);

      storeGoalList(_data.goalList);
      addGoalRemote(goal);
    });
  }

  void addNotExistGoals(List<Goal> goals) {
    setState(() {
      List<Goal> curGoal = List<Goal>.from(_data.goalList);
      curGoal.addAll(goals.where((newElement) => _data.goalList
          .every((existElement) => existElement.id != newElement.id)));
      _data = _data.copyWith(goalsList: curGoal);

      storeGoalList(_data.goalList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      _data,
      child: widget.child,
    );
  }
}
