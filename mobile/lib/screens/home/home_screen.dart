import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../capture/capture_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt, size: 24),
            SizedBox(width: 8),
            Text('ACTIFY'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: ActifyTheme.neonCyan.withValues(alpha: 0.08),
                border: Border.all(color: ActifyTheme.neonCyan.withValues(alpha: 0.35)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.circle, size: 7, color: ActifyTheme.neonCyan),
                  SizedBox(width: 6),
                  Text('SYSTEM READY', style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w800,
                    color: ActifyTheme.neonCyan, letterSpacing: 1,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('PERSONAL ACTION INTELLIGENCE',
                style: TextStyle(
                  color: ActifyTheme.neonCyan, fontSize: 10,
                  fontWeight: FontWeight.w800, letterSpacing: 1.8,
                )),
              const SizedBox(height: 10),
              Text('Make your next\nmove count.',
                style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 10),
              Text(
                'Capture the noise. Find the signal. Take action.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF14283A), Color(0xFF101827), Color(0xFF15132A)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ActifyTheme.neonCyan.withValues(alpha: 0.4)),
                  boxShadow: [
                    BoxShadow(
                      color: ActifyTheme.neonCyan.withValues(alpha: 0.06),
                      blurRadius: 26,
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
                        Text('NEXT BEST ACTION',
                          style: TextStyle(
                            color: ActifyTheme.neonCyan,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                            letterSpacing: 1.5,
                          )),
                        Spacer(),
                        Icon(Icons.more_horiz, color: ActifyTheme.textMuted),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Icon(Icons.center_focus_strong,
                      color: ActifyTheme.textMuted, size: 34),
                    const SizedBox(height: 14),
                    Text('Your focus starts here.',
                      style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Add a task, note, or screenshot. ACTIFY will help turn it into a clear next step.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 22),
                    const Row(
                      children: [
                        _SignalChip(icon: Icons.bolt, label: 'PRIORITIZE'),
                        SizedBox(width: 8),
                        _SignalChip(icon: Icons.route, label: 'PLAN'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Text('QUICK CAPTURE',
                style: TextStyle(
                  color: ActifyTheme.textMuted, fontWeight: FontWeight.w800,
                  fontSize: 10, letterSpacing: 1.6,
                )),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(child: _CaptureOption(icon: Icons.camera_alt_outlined, label: 'Scan')),
                  SizedBox(width: 10),
                  Expanded(child: _CaptureOption(icon: Icons.mic_none, label: 'Voice')),
                  SizedBox(width: 10),
                  Expanded(child: _CaptureOption(icon: Icons.image_outlined, label: 'Image')),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CaptureScreen()),
                  ),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('INITIALIZE CAPTURE'),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text('CAPTURE  /  UNDERSTAND  /  ACT',
                  style: TextStyle(
                    color: ActifyTheme.textMuted, fontSize: 9,
                    fontWeight: FontWeight.w700, letterSpacing: 1.8,
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignalChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SignalChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: ActifyTheme.background.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ActifyTheme.outline),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: ActifyTheme.neonCyan),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 9,
            fontWeight: FontWeight.w800, letterSpacing: 0.7)),
        ],
      ),
    );
  }
}

class _CaptureOption extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CaptureOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      decoration: BoxDecoration(
        color: ActifyTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ActifyTheme.outline),
      ),
      child: Column(
        children: [
          Icon(icon, size: 23, color: ActifyTheme.electricBlue),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        ],
      ),
    );
  }
}
