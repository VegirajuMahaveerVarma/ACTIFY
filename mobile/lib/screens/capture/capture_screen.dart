import 'package:flutter/material.dart';
import '../../app/theme.dart';

class CaptureScreen extends StatelessWidget {
  const CaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture'),
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Text(
            'Start anywhere.',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Choose a simple way to get it out of your head.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: ActifyTheme.textMuted,
            ),
          ),
          const SizedBox(height: 26),
          const _CaptureTile(
            icon: Icons.edit_note_rounded,
            title: 'Write a note',
            subtitle: 'Capture an idea, task, or reminder',
          ),
          const _CaptureTile(
            icon: Icons.mic_none_rounded,
            title: 'Record a voice note',
            subtitle: 'Describe what needs to get done',
          ),
          const _CaptureTile(
            icon: Icons.image_outlined,
            title: 'Add a screenshot',
            subtitle: 'Keep details from an image in one place',
          ),
          const _CaptureTile(
            icon: Icons.document_scanner_outlined,
            title: 'Scan a document',
            subtitle: 'Assignments, notices, and paper notes',
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: ActifyTheme.surface,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: ActifyTheme.outline),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded,
                    color: ActifyTheme.textMuted, size: 19),
                SizedBox(width: 11),
                Expanded(
                  child: Text(
                    'These options are the capture interface. Camera, OCR, voice recording, and import processing require their respective integrations.',
                    style: TextStyle(
                      color: ActifyTheme.textMuted,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CaptureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _CaptureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        leading: Icon(icon, color: ActifyTheme.textMuted, size: 24),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: ActifyTheme.textMuted,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_rounded,
          color: ActifyTheme.textMuted,
          size: 17,
        ),
      ),
    );
  }
}
