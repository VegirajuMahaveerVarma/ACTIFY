import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final priorityColor = switch (task.priority.name.toLowerCase()) {
      'high' => ActifyTheme.danger,
      'medium' => const Color(0xFFE5BE67),
      _ => ActifyTheme.accent,
    };

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        title: Text(
          task.title,
          style: const TextStyle(
            color: ActifyTheme.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            spacing: 10,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(Icons.schedule_rounded, size: 14, color: ActifyTheme.textMuted),
              Text('${task.estimatedMinutes} min'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '${task.priority.name.toUpperCase()}',
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_rounded,
          size: 17,
          color: ActifyTheme.textMuted,
        ),
      ),
    );
  }
}
