import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_tracker_app/model/goal.dart' show Goal;
import 'package:json_annotation/json_annotation.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState {
  final List<Goal> goalList;
  AppState({
    this.goalList = const <Goal>[],
  });

  AppState copyWith({
    List<Goal>? goalsList,
    User? user,
  }) {
    return AppState(
      goalList: goalsList ?? this.goalList,
    );
  }

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
  static fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
}
