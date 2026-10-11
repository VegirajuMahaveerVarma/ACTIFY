import 'package:flutter/material.dart';

import '../../models/task.dart';
import '../../app/theme.dart';
import '../capture/capture_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];

  List<Task> get _openTasks =>
      _tasks.where((task) => task.status != TaskStatus.completed).toList()
        ..sort((a, b) {
          final priorityOrder = {
            TaskPriority.high: 0,
            TaskPriority.medium: 1,
            TaskPriority.low: 2,
          };
          final byPriority =
              priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
          if (byPriority != 0) return byPriority;
          if (a.deadline == null && b.deadline == null) return 0;
          if (a.deadline == null) return 1;
          if (b.deadline == null) return -1;
          return a.deadline!.compareTo(b.deadline!);
        });

  Future<void> _captureTask() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const CaptureScreen()),
    );
    if (!mounted || result == null || (result['title'] ?? '').trim().isEmpty) {
      return;
    }
    setState(() {
      _tasks.insert(
        0,
        Task(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: result['title']!.trim(),
          source: result['source'] ?? 'manual',
          priority: TaskPriority.medium,
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task added to your action list')),
    );
  }

  void _toggleTask(Task task, bool completed) {
    setState(() {
      final index = _tasks.indexWhere((item) => item.id == task.id);
      if (index == -1) return;
      final old = _tasks[index];
      _tasks[index] = Task(
        id: old.id,
        title: old.title,
        description: old.description,
        deadline: old.deadline,
        estimatedMinutes: old.estimatedMinutes,
        priority: old.priority,
        status: completed ? TaskStatus.completed : TaskStatus.pending,
        source: old.source,
      );
    });
  }

  String get _dateLabel {
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final now = DateTime.now();
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    final openTasks = _openTasks;
    final completed = _tasks.where((task) => task.status == TaskStatus.completed).length;
    final next = openTasks.isEmpty ? null : openTasks.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ACTIFY'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 18),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: ActifyTheme.accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ActifyTheme.accent.withOpacity(0.35)),
            ),
            child: const Row(
              children: [
                Icon(Icons.bolt_rounded, size: 15, color: ActifyTheme.accent),
                SizedBox(width: 4),
                Text('FOCUS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: ActifyTheme.accent)),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Text(_dateLabel, style: const TextStyle(color: ActifyTheme.muted, fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('Make today\ncount.', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900, height: 1.05, letterSpacing: -1.2)),
            const SizedBox(height: 10),
            const Text('Capture the noise. ACTIFY the next step.', style: TextStyle(color: ActifyTheme.muted, fontSize: 14)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _StatCard(label: 'TO DO', value: '${openTasks.length}', icon: Icons.radio_button_unchecked_rounded)),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(label: 'COMPLETED', value: '$completed', icon: Icons.check_circle_outline_rounded)),
              ],
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF25251D), Color(0xFF151A20), Color(0xFF11151B)],
                ),
                border: Border.all(color: ActifyTheme.accent.withOpacity(0.35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: ActifyTheme.accent, size: 18),
                      SizedBox(width: 8),
                      Text('NEXT BEST ACTION', style: TextStyle(color: ActifyTheme.accent, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.3)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    next?.title ?? 'Start with one small win.',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, height: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    next == null
                        ? 'Add a task from your notes, ideas, or to-do list. Your action plan starts here.'
                        : '${next.estimatedMinutes} min · ${next.priority.name.toUpperCase()} priority · Keep the momentum going.',
                    style: const TextStyle(color: ActifyTheme.muted, height: 1.45),
                  ),
                  if (next != null) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _toggleTask(next, true),
                        icon: const Icon(Icons.check_rounded),
                        label: const Text('Mark as done'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Text('Your actions', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const Spacer(),
                Text('${_tasks.length} total', style: const TextStyle(color: ActifyTheme.muted, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 14),
            if (_tasks.isEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                decoration: BoxDecoration(
                  color: ActifyTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF252B35)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.inbox_rounded, size: 30, color: ActifyTheme.muted),
                    SizedBox(height: 10),
                    Text('Your list is clear', style: TextStyle(fontWeight: FontWeight.w800)),
                    SizedBox(height: 5),
                    Text('Capture a task to turn an intention into action.', textAlign: TextAlign.center, style: TextStyle(color: ActifyTheme.muted, height: 1.4)),
                  ],
                ),
              )
            else
              ..._tasks.map((task) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _TaskRow(task: task, onChanged: (value) => _toggleTask(task, value)),
              )),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _captureTask,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Capture another task'),
            ),
            const SizedBox(height: 12),
            const Center(child: Text('Small steps. Real progress.', style: TextStyle(color: ActifyTheme.muted, fontSize: 12))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _captureTask,
        backgroundColor: ActifyTheme.accent,
        foregroundColor: const Color(0xFF17140A),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Capture', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ActifyTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF252B35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ActifyTheme.accent, size: 19),
          const SizedBox(height: 12),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(color: ActifyTheme.muted, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1)),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  final Task task;
  final ValueChanged<bool> onChanged;

  const _TaskRow({required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final done = task.status == TaskStatus.completed;
    final priorityColor = task.priority == TaskPriority.high
        ? const Color(0xFFFF8B72)
        : task.priority == TaskPriority.medium
            ? ActifyTheme.accent
            : const Color(0xFF8EB9FF);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: ActifyTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF252B35)),
      ),
      child: Row(
        children: [
          Checkbox(
            value: done,
            onChanged: (value) => onChanged(value ?? false),
            activeColor: ActifyTheme.accent,
            checkColor: const Color(0xFF17140A),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: TextStyle(fontWeight: FontWeight.w700, decoration: done ? TextDecoration.lineThrough : null, color: done ? ActifyTheme.muted : Colors.white)),
                const SizedBox(height: 5),
                Text('${task.estimatedMinutes} min · ${task.source}', style: const TextStyle(color: ActifyTheme.muted, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(color: priorityColor.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
            child: Text(task.priority.name, style: TextStyle(color: priorityColor, fontSize: 11, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}
