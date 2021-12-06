import 'package:habit_tracker_app/model/goal.dart' show Goal;

class AppState {
  final List<Goal> goalList;
  AppState({
    this.goalList = const <Goal>[],
  });

  AppState copyWith({
    List<Goal>? goalsList,
  }) {
    return AppState(
      goalList: goalsList ?? this.goalList,
    );
  }
}
