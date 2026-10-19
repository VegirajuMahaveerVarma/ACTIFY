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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF14283A), ActifyTheme.surface, Color(0xFF15132A)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ActifyTheme.neonCyan.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: ActifyTheme.neonCyan.withValues(alpha: 0.06),
            blurRadius: 24,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.radar, color: ActifyTheme.neonCyan, size: 20),
              SizedBox(width: 8),
              Text(
                'NEXT BEST ACTION',
                style: TextStyle(
                  color: ActifyTheme.neonCyan,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
