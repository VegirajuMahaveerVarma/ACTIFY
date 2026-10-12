import 'package:flutter/material.dart';
import '../app/theme.dart';

class NextActionCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const NextActionCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF17221F), ActifyTheme.surface],
        ),
        border: Border.all(color: ActifyTheme.neon.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.bolt_rounded, color: ActifyTheme.neon, size: 17),
                SizedBox(width: 8),
                Text(
                  'NEXT BEST ACTION',
                  style: TextStyle(
                    color: ActifyTheme.neon,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 7),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ActifyTheme.muted,
                    height: 1.4,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
