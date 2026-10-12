import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          leading: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: ActifyTheme.neon.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: ActifyTheme.neon.withValues(alpha: 0.18)),
            ),
            child: const Icon(Icons.terminal_rounded, color: ActifyTheme.neon, size: 19),
          ),
          title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              '${task.estimatedMinutes} min  •  ${task.priority.name} priority',
              style: const TextStyle(color: ActifyTheme.muted, fontSize: 12),
            ),
          ),
          trailing: const Icon(Icons.arrow_outward_rounded, color: ActifyTheme.neon, size: 18),
        ),
      ),
    );
  }
}
