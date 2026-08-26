import 'task.dart';

class ScheduleItem {
  final Task task;
  final DateTime start;
  final DateTime end;

  const ScheduleItem({required this.task, required this.start, required this.end});
}
