import 'package:flutter/material.dart';
import '../app/theme.dart';

class NextActionCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const NextActionCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ActifyTheme.surface,
        borderRadius: BorderRadius.circular(16),
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
                'NEXT BEST ACTION',
                style: TextStyle(
                  color: ActifyTheme.textMuted,
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
