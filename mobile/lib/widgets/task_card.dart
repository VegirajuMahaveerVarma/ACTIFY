import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text('${task.estimatedMinutes} min • ${task.priority.name} priority'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
