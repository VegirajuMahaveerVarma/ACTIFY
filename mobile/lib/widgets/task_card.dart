import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final color = switch (task.priority) {
      TaskPriority.high => const Color(0xFFFF8B72),
      TaskPriority.medium => ActifyTheme.accent,
      TaskPriority.low => const Color(0xFF8EB9FF),
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(Icons.task_alt_rounded, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 5),
                  Text('${task.estimatedMinutes} min · ${task.source}', style: const TextStyle(color: ActifyTheme.muted, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.circle, size: 8, color: color),
          ],
        ),
      ),
    );
  }
}
