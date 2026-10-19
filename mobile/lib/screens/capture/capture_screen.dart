import 'package:flutter/material.dart';
import '../../app/theme.dart';

class CaptureScreen extends StatelessWidget {
  const CaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAPTURE INTAKE'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const Text(
            'Bring it in.',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose an input channel. Turn scattered information into your next action.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 26),
          const _CaptureTile(
            icon: Icons.document_scanner_outlined,
            title: 'Scan a document',
            subtitle: 'Assignments, notices, and paper notes',
            tag: 'CAMERA',
          ),
          const _CaptureTile(
            icon: Icons.graphic_eq,
            title: 'Record a voice note',
            subtitle: 'Describe what needs to get done',
            tag: 'AUDIO',
          ),
          const _CaptureTile(
            icon: Icons.screenshot_monitor_outlined,
            title: 'Import a screenshot',
            subtitle: 'Extract useful tasks from an image',
            tag: 'IMAGE',
          ),
          const _CaptureTile(
            icon: Icons.terminal,
            title: 'Enter text manually',
            subtitle: 'Quickly capture an idea or reminder',
            tag: 'TEXT',
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ActifyTheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: ActifyTheme.outline),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shield_outlined, color: ActifyTheme.neonCyan),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Capture options are a UI foundation. Camera, OCR, voice recording, and import flows need their respective integrations before they can process input.',
                    style: TextStyle(color: ActifyTheme.textMuted, height: 1.4),
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
  final String tag;

  const _CaptureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: ActifyTheme.neonCyan.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: ActifyTheme.neonCyan.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, color: ActifyTheme.neonCyan),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ),
        trailing: const Icon(Icons.chevron_right, color: ActifyTheme.textMuted),
      ),
    );
  }
}
