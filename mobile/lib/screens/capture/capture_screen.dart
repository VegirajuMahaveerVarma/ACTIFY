import 'package:flutter/material.dart';

class CaptureScreen extends StatelessWidget {
  const CaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capture')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('What do you want to add?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _CaptureTile(icon: Icons.camera_alt, title: 'Scan', subtitle: 'Capture a notice, assignment or document.'),
          _CaptureTile(icon: Icons.mic, title: 'Voice', subtitle: 'Describe a task naturally.'),
          _CaptureTile(icon: Icons.image, title: 'Screenshot', subtitle: 'Turn an image into an actionable task.'),
          _CaptureTile(icon: Icons.edit_document, title: 'Text', subtitle: 'Enter a task manually.'),
        ],
      ),
    );
  }
}

class _CaptureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _CaptureTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
