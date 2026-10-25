import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../services/api_service.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  final TextEditingController _inputController = TextEditingController();
  bool _isExtracting = false;
  String? _error;
  Map<String, dynamic>? _extractedTask;

  ApiService get _api => const ApiService(
        baseUrl: String.fromEnvironment(
          'ACTIFY_API_URL',
          defaultValue: 'http://10.0.2.2:8000',
        ),
      );

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _extractTask() async {
    final input = _inputController.text.trim();
    if (input.isEmpty) {
      setState(() => _error = 'Enter a note before extracting a task.');
      return;
    }
    setState(() {
      _isExtracting = true;
      _error = null;
      _extractedTask = null;
    });
    try {
      final task = await _api.extractTask(input);
      if (!mounted) return;
      setState(() => _extractedTask = task);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error =
          'Could not reach ACTIFY. Check that the backend is running and ACTIFY_API_URL is configured for your device.');
    } finally {
      if (mounted) setState(() => _isExtracting = false);
    }
  }

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
          Text('Bring it in.', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(
            'Start with a note. ACTIFY will turn it into a structured task you can review.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          const Text('TEXT INPUT', style: TextStyle(
            color: ActifyTheme.neonCyan, fontSize: 10,
            fontWeight: FontWeight.w800, letterSpacing: 1.6,
          )),
          const SizedBox(height: 10),
          TextField(
            controller: _inputController,
            minLines: 4,
            maxLines: 8,
            maxLength: 4000,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'e.g. Finish the ML assignment by Friday and spend 45 minutes on it.',
              alignLabelWithHint: true,
            ),
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
          ),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: FilledButton.icon(
            onPressed: _isExtracting ? null : _extractTask,
            icon: _isExtracting
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(
                    strokeWidth: 2, color: ActifyTheme.background,
                  ))
                : const Icon(Icons.auto_awesome),
            label: Text(_isExtracting ? 'ANALYZING INPUT...' : 'EXTRACT TASK'),
          )),
          if (_error != null) ...[
            const SizedBox(height: 14),
            _MessageCard(message: _error!, isError: true),
          ],
          if (_extractedTask != null) ...[
            const SizedBox(height: 22),
            _ExtractedTaskCard(task: _extractedTask!),
          ],
          const SizedBox(height: 24),
          const _CapabilityNote(),
        ],
      ),
    );
  }
}

class _ExtractedTaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  const _ExtractedTaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final priority = (task['priority'] as String? ?? 'medium').toUpperCase();
    final priorityColor = switch (priority.toLowerCase()) {
      'high' => const Color(0xFFFF6B8A),
      'low' => ActifyTheme.neonCyan,
      _ => ActifyTheme.neonViolet,
    };
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ActifyTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ActifyTheme.neonCyan.withValues(alpha: 0.4)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.check_circle_outline, color: ActifyTheme.neonCyan),
          SizedBox(width: 8),
          Text('EXTRACTED TASK', style: TextStyle(
            color: ActifyTheme.neonCyan, fontWeight: FontWeight.w800,
            fontSize: 11, letterSpacing: 1.4,
          )),
        ]),
        const SizedBox(height: 16),
        Text(task['title'] as String? ?? 'Untitled task',
            style: Theme.of(context).textTheme.titleLarge),
        if ((task['description'] as String? ?? '').isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(task['description'] as String, style: Theme.of(context).textTheme.bodyMedium),
        ],
        const SizedBox(height: 14),
        Wrap(spacing: 8, runSpacing: 8, children: [
          _Tag(label: priority, color: priorityColor),
          _Tag(label: '${task['estimated_minutes'] ?? 30} MIN', color: ActifyTheme.electricBlue),
          _Tag(label: (task['category'] as String? ?? 'general').toUpperCase(), color: ActifyTheme.neonViolet),
        ]),
        const SizedBox(height: 12),
        Text(
          'Provider: ${task['provider'] ?? 'unknown'} · Confidence: ${((task['confidence'] as num?) ?? 0).toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        if (task['deadline'] != null) ...[
          const SizedBox(height: 8),
          Text('Deadline: ${task['deadline']}', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ]),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(label, style: TextStyle(
      color: color, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.6,
    )),
  );
}

class _MessageCard extends StatelessWidget {
  final String message;
  final bool isError;
  const _MessageCard({required this.message, required this.isError});

  @override
  Widget build(BuildContext context) {
    final color = isError ? const Color(0xFFFF6B8A) : ActifyTheme.neonCyan;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(message, style: TextStyle(color: color, height: 1.45)),
    );
  }
}

class _CapabilityNote extends StatelessWidget {
  const _CapabilityNote();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: ActifyTheme.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: ActifyTheme.outline),
    ),
    child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(Icons.info_outline, color: ActifyTheme.textMuted),
      SizedBox(width: 12),
      Expanded(child: Text(
        'Text extraction is connected to the backend. Camera scanning, OCR, and voice capture remain separate integrations and are not shown as completed features yet.',
        style: TextStyle(color: ActifyTheme.textMuted, height: 1.4),
      )),
    ]),
  );
}
