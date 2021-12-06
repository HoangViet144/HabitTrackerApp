class Goal {
  final int id;
  final String description;
  final double progress;
  final int priority;
  final DateTime? dueDate;
  Goal({
    this.id = 0,
    this.description = "",
    this.progress = 0,
    this.priority = 0,
    this.dueDate,
  });
  Goal copyWith({
    int? id,
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
}
