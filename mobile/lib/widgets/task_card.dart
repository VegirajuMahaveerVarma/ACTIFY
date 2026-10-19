import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final priorityColor = switch (task.priority.name.toLowerCase()) {
      'high' => const Color(0xFFFF6B8A),
      'medium' => ActifyTheme.neonViolet,
      _ => ActifyTheme.neonCyan,
    };

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              const Icon(Icons.schedule, size: 14, color: ActifyTheme.textMuted),
              const SizedBox(width: 5),
              Text('${task.estimatedMinutes} min'),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: priorityColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '${task.priority.name.toUpperCase()} PRIORITY',
                  style: TextStyle(color: priorityColor, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.6),
                ),
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: ActifyTheme.neonCyan),
      ),
    );
  }
}
