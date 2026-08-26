enum TaskPriority { low, medium, high }

enum TaskStatus { pending, inProgress, completed }

class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime? deadline;
  final int estimatedMinutes;
  final TaskPriority priority;
  final TaskStatus status;
  final String source;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    this.estimatedMinutes = 30,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.pending,
    this.source = 'manual',
  });
}
