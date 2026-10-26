import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../capture/capture_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
              padding: EdgeInsets.fromLTRB(horizontal, 20, horizontal, 28),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MONDAY, YOUR WAY',
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
                      const SizedBox(height: 30),
                      const _FocusCard(),
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
                      const SizedBox(height: 16),
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

class _FocusCard extends StatelessWidget {
  const _FocusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: ActifyTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ActifyTheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.center_focus_strong_rounded,
                  color: ActifyTheme.accent, size: 18),
              SizedBox(width: 8),
              Text(
                'YOUR FOCUS',
                style: TextStyle(
                  color: ActifyTheme.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'One thing at a time.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your next step will feel clearer once you capture what is competing for your attention.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 22),
          Container(height: 1, color: ActifyTheme.outline),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.check_circle_outline_rounded,
                  color: ActifyTheme.accent, size: 17),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Capture  ·  Clarify  ·  Act',
                  style: TextStyle(
                    color: ActifyTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              Icon(Icons.arrow_outward_rounded,
                  color: ActifyTheme.textMuted, size: 17),
            ],
          ),
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
