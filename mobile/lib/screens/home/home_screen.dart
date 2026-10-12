import 'package:flutter/material.dart';
import '../capture/capture_screen.dart';
import '../../app/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ACTIFY'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: ActifyTheme.neon.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ActifyTheme.neon.withValues(alpha: 0.3)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, size: 7, color: ActifyTheme.neon),
                SizedBox(width: 7),
                Text(
                  'SYSTEM READY',
                  style: TextStyle(
                    color: ActifyTheme.neon,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionLabel(label: 'PERSONAL COMMAND CENTER', icon: Icons.terminal_rounded),
              const SizedBox(height: 16),
              Text(
                'What should I do\nright now?',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.08,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Turn the noise into your next move.',
                style: textTheme.bodyMedium?.copyWith(color: ActifyTheme.muted),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF17221F), Color(0xFF101619), Color(0xFF0D1214)],
                  ),
                  border: Border.all(color: ActifyTheme.neon.withValues(alpha: 0.34)),
                  boxShadow: [
                    BoxShadow(
                      color: ActifyTheme.neon.withValues(alpha: 0.04),
                      blurRadius: 28,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: ActifyTheme.neon.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.bolt_rounded, color: ActifyTheme.neon, size: 20),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'NEXT BEST ACTION',
                              style: TextStyle(
                                color: ActifyTheme.neon,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          const Icon(Icons.more_horiz, color: ActifyTheme.muted),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Awaiting your first input',
                        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Capture a thought, task, or deadline. ACTIFY will help turn it into a clear next step.',
                        style: textTheme.bodyMedium?.copyWith(color: ActifyTheme.muted, height: 1.45),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Icon(Icons.memory_rounded, size: 15, color: ActifyTheme.neon),
                          SizedBox(width: 7),
                          Text(
                            'INTELLIGENCE LOOP STANDING BY',
                            style: TextStyle(
                              fontSize: 9,
                              color: ActifyTheme.muted,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.7,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                decoration: BoxDecoration(
                  color: ActifyTheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: ActifyTheme.outline),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.shield_outlined, size: 18, color: ActifyTheme.muted),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Less planning. More execution.',
                        style: TextStyle(color: ActifyTheme.muted, fontSize: 12),
                      ),
                    ),
                    Text(
                      'v0.1',
                      style: TextStyle(
                        color: ActifyTheme.neon,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CaptureScreen()),
                  ),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Capture something'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SectionLabel({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: ActifyTheme.neon, size: 15),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: ActifyTheme.muted,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.3,
          ),
        ),
      ],
    );
  }
}
