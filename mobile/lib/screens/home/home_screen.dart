import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../capture/capture_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<_HomeTask> _tasks = [
    _HomeTask(title: 'Review today’s priorities', done: false),
    _HomeTask(title: 'Make progress on one important task', done: false),
    _HomeTask(title: 'Take a short reset break', done: true),
  ];

  int get _completedTasks => _tasks.where((task) => task.done).length;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateLabel = _weekday(now.weekday).toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BrandMark(),
            SizedBox(width: 10),
            Text('actify'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _StatusDot(),
                SizedBox(width: 7),
                Text(
                  'READY',
                  style: TextStyle(
                    color: ActifyTheme.textMuted,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontal = constraints.maxWidth > 650 ? 32.0 : 20.0;
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(horizontal, 20, horizontal, 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$dateLabel, YOUR WAY',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: ActifyTheme.textMuted,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Make room\nfor what matters.',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Text(
                          'Gather your tasks, find your focus, and take the next step.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ActifyTheme.textMuted,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      _ProgressCard(
                        completed: _completedTasks,
                        total: _tasks.length,
                        tasks: _tasks,
                        onToggle: _toggleTask,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Capture something',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Icon(Icons.arrow_downward_rounded, size: 17),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Start with what is on your mind.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      const _CaptureChoice(
                        icon: Icons.edit_note_rounded,
                        title: 'Write a note',
                        subtitle: 'An idea, task, or reminder',
                      ),
                      const _CaptureChoice(
                        icon: Icons.mic_none_rounded,
                        title: 'Record a voice note',
                        subtitle: 'Get it out of your head',
                      ),
                      const _CaptureChoice(
                        icon: Icons.image_outlined,
                        title: 'Add an image',
                        subtitle: 'A screenshot, note, or document',
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CaptureScreen(),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Start capturing'),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'LESS NOISE. MORE INTENTION.',
                          style: TextStyle(
                            color: ActifyTheme.textMuted,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _toggleTask(int index) {
    setState(() => _tasks[index].done = !_tasks[index].done);
  }

  String _weekday(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday - 1];
  }
}

class _HomeTask {
  final String title;
  bool done;

  _HomeTask({required this.title, required this.done});
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: ActifyTheme.accent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.bolt_rounded,
        color: ActifyTheme.background,
        size: 19,
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: ActifyTheme.accent,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final int completed;
  final int total;
  final List<_HomeTask> tasks;
  final ValueChanged<int> onToggle;

  const _ProgressCard({
    required this.completed,
    required this.total,
    required this.tasks,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : completed / total;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ActifyTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ActifyTheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.center_focus_strong_rounded,
                color: ActifyTheme.accent,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'TODAY’S FOCUS',
                  style: TextStyle(
                    color: ActifyTheme.textMuted,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
              Text(
                '$completed / $total DONE',
                style: const TextStyle(
                  color: ActifyTheme.accent,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.7,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: ActifyTheme.surfaceRaised,
              valueColor: const AlwaysStoppedAnimation<Color>(
                ActifyTheme.accent,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            completed == total ? 'You showed up today.' : 'One thing at a time.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            completed == total
                ? 'Your list is clear. Take a moment to reset.'
                : 'Small steps make a meaningful day.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          ...List.generate(tasks.length, (index) {
            final task = tasks[index];
            return CheckboxListTile(
              value: task.done,
              onChanged: (_) => onToggle(index),
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: ActifyTheme.accent,
              checkColor: ActifyTheme.background,
              title: Text(
                task.title,
                style: TextStyle(
                  color: task.done
                      ? ActifyTheme.textMuted
                      : ActifyTheme.textPrimary,
                  fontSize: 12,
                  decoration: task.done ? TextDecoration.lineThrough : null,
                  decorationColor: ActifyTheme.textMuted,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CaptureChoice extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _CaptureChoice({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: ActifyTheme.surface,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: ActifyTheme.outline),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        leading: Icon(icon, size: 22, color: ActifyTheme.textMuted),
        title: Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: ActifyTheme.textMuted,
              fontSize: 11,
            ),
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
