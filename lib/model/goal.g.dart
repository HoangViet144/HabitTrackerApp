// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      id: json['id'] as String? ?? "",
      description: json['description'] as String? ?? "",
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      priority: json['priority'] as int? ?? 0,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
    );

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'progress': instance.progress,
      'priority': instance.priority,
      'dueDate': instance.dueDate?.toIso8601String(),
    };
