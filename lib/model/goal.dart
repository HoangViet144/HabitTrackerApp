import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

@JsonSerializable()
class Goal {
  final String id;
  final String description;
  final double progress;
  final int priority;
  final DateTime? dueDate;
  const Goal({
    this.id = "",
    this.description = "",
    this.progress = 0,
    this.priority = 0,
    this.dueDate,
  });
  Goal copyWith({
    String? id,
    String? description,
    double? progress,
    int? priority,
    DateTime? dueDate,
  }) {
    return Goal(
      id: id ?? this.id,
      description: description ?? this.description,
      progress: progress ?? this.progress,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  static fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
