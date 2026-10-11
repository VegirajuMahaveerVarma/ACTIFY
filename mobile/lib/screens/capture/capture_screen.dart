import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../services/camera_service.dart';
import '../../services/voice_service.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  final _controller = TextEditingController();
  final _voiceService = VoiceService();
  final _cameraService = CameraService();
  String _source = 'manual';
  bool _listening = false;
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveTask() {
    final title = _controller.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add a task or dictate one first.')),
      );
      return;
    }
    setState(() => _saving = true);
    Navigator.pop(context, <String, String>{'title': title, 'source': _source});
  }

  Future<void> _captureVoice() async {
    setState(() => _listening = true);
    try {
      final words = await _voiceService.listenOnce();
      if (!mounted) return;
      if (words.trim().isNotEmpty) {
        setState(() {
          _controller.text = words.trim();
          _source = 'voice';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No speech detected. Try again or type your task.')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voice input is unavailable. You can type your task instead.')),
        );
      }
    } finally {
      if (mounted) setState(() => _listening = false);
    }
  }

  Future<void> _captureImage() async {
    try {
      final image = await _cameraService.capture();
      if (!mounted || image == null) return;
      setState(() => _source = 'camera');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo captured. Add a short description below; image-to-text extraction is not connected yet.')),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the camera. You can type your task instead.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CAPTURE')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ActifyTheme.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFF303744)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.bolt_rounded, color: ActifyTheme.accent, size: 28),
                  SizedBox(height: 16),
                  Text('Get it out of your head.', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, height: 1.15, letterSpacing: -0.6)),
                  SizedBox(height: 8),
                  Text('Write it down or say it out loud. You can organize it later.', style: TextStyle(color: ActifyTheme.muted, height: 1.45)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('YOUR TASK', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.3, color: ActifyTheme.muted)),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              autofocus: true,
              minLines: 4,
              maxLines: 7,
              maxLength: 4000,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) {
                if (_source != 'manual') setState(() => _source = 'manual');
              },
              decoration: const InputDecoration(
                hintText: 'e.g. Finish the ML assignment before Friday...',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: _listening ? null : _captureVoice,
              icon: Icon(_listening ? Icons.graphic_eq_rounded : Icons.mic_none_rounded),
              label: Text(_listening ? 'Listening…' : 'Dictate with voice'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _captureImage,
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Capture a photo'),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _saving ? null : _saveTask,
              icon: const Icon(Icons.add_task_rounded),
              label: const Text('Add to my actions'),
            ),
            const SizedBox(height: 12),
            const Text('Tasks are currently kept in this app session. Persistent sync and OCR can be connected in the next iteration.', textAlign: TextAlign.center, style: TextStyle(color: ActifyTheme.muted, fontSize: 12, height: 1.45)),
          ],
        ),
      ),
    );
  }
}
