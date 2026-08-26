import 'package:flutter/material.dart';

class NextActionCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const NextActionCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('NEXT BEST ACTION', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(subtitle),
        ]),
      ),
    );
  }
}
