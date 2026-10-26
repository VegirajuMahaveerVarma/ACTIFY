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
            _BrandMark(),
            SizedBox(width: 10),
            Text('ACTIFY'),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: _SystemStatus(),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth > 600 ? 32.0 : 20.0;
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 14, horizontalPadding, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Eyebrow(label: 'PERSONAL ACTION INTELLIGENCE'),
                      const SizedBox(height: 14),
                      Text(
                        'Make your next\nmove count.',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Capture the noise. Find the signal. Take action.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 26),
                      const _MissionPanel(),
                      const SizedBox(height: 28),
                      const Row(
                        children: [
                          Expanded(
                            child: _SectionHeading(
                              title: 'QUICK CAPTURE',
                              subtitle: 'Choose an input channel',
                            ),
                          ),
                          _TinyStatusDot(),
                        ],
                      ),
                      const SizedBox(height: 14),
                      LayoutBuilder(
                        builder: (context, innerConstraints) {
                          final items = const [
                            _CaptureOption(
                              icon: Icons.document_scanner_outlined,
                              label: 'Scan',
                              detail: 'Documents',
                            ),
                            _CaptureOption(
                              icon: Icons.graphic_eq,
                              label: 'Voice',
                              detail: 'Voice notes',
                            ),
                            _CaptureOption(
                              icon: Icons.image_outlined,
                              label: 'Image',
                              detail: 'Screenshots',
                            ),
                          ];
                          if (innerConstraints.maxWidth < 340) {
                            return Column(
                              children: [
                                for (final item in items) ...[
                                  item,
                                  const SizedBox(height: 10),
                                ],
                              ],
                            );
                          }
                          return Row(
                            children: [
                              for (var i = 0; i < items.length; i++) ...[
                                if (i > 0) const SizedBox(width: 10),
                                Expanded(child: items[i]),
                              ],
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: ActifyTheme.surface.withValues(alpha: 0.74),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: ActifyTheme.outline),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.lock_outline, size: 17, color: ActifyTheme.neonCyan),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'One focused workspace for your next best action.',
                                style: TextStyle(
                                  color: ActifyTheme.textMuted,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_outward, size: 16, color: ActifyTheme.textMuted),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CaptureScreen()),
                          ),
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('INITIALIZE CAPTURE'),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Center(
                        child: Text(
                          'CAPTURE  /  UNDERSTAND  /  ACT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ActifyTheme.textMuted,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ActifyTheme.neonCyan, ActifyTheme.electricBlue],
        ),
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: ActifyTheme.neonCyan.withValues(alpha: 0.20),
            blurRadius: 16,
          ),
        ],
      ),
      child: const Icon(Icons.bolt_rounded, color: ActifyTheme.background, size: 20),
    );
  }
}

class _SystemStatus extends StatelessWidget {
  const _SystemStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: ActifyTheme.neonCyan.withValues(alpha: 0.07),
        border: Border.all(color: ActifyTheme.neonCyan.withValues(alpha: 0.28)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TinyStatusDot(),
          SizedBox(width: 7),
          Text(
            'READY',
            style: TextStyle(
              color: ActifyTheme.neonCyan,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  final String label;
  const _Eyebrow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 2,
          decoration: BoxDecoration(
            color: ActifyTheme.neonCyan,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 9),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              color: ActifyTheme.neonCyan,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _MissionPanel extends StatelessWidget {
  const _MissionPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF132B3B),
            Color(0xFF101827),
            Color(0xFF17132D),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ActifyTheme.neonCyan.withValues(alpha: 0.33)),
        boxShadow: [
          BoxShadow(
            color: ActifyTheme.neonCyan.withValues(alpha: 0.06),
            blurRadius: 28,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -18,
            child: Icon(
              Icons.blur_circular,
              size: 132,
              color: ActifyTheme.neonCyan.withValues(alpha: 0.045),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.radar_rounded, color: ActifyTheme.neonCyan, size: 19),
                  SizedBox(width: 8),
                  Text(
                    'NEXT BEST ACTION',
                    style: TextStyle(
                      color: ActifyTheme.neonCyan,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Spacer(),
                  _LiveTag(),
                ],
              ),
              const SizedBox(height: 26),
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: ActifyTheme.background.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ActifyTheme.outline),
                ),
                child: const Icon(
                  Icons.center_focus_strong_rounded,
                  color: ActifyTheme.neonCyan,
                  size: 27,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your focus starts here.',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 21),
              ),
              const SizedBox(height: 8),
              Text(
                'Add a task, note, or screenshot. Turn it into a clear next step.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _SignalChip(icon: Icons.bolt_rounded, label: 'PRIORITIZE'),
                  _SignalChip(icon: Icons.route_rounded, label: 'PLAN'),
                  _SignalChip(icon: Icons.track_changes_rounded, label: 'FOCUS'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LiveTag extends StatelessWidget {
  const _LiveTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: ActifyTheme.neonViolet.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: ActifyTheme.neonViolet.withValues(alpha: 0.25)),
      ),
      child: const Text(
        'AI READY',
        style: TextStyle(
          color: ActifyTheme.neonViolet,
          fontSize: 8,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
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
        color: ActifyTheme.background.withValues(alpha: 0.54),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ActifyTheme.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: ActifyTheme.neonCyan),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeading({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ActifyTheme.textPrimary,
            fontWeight: FontWeight.w900,
            fontSize: 11,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: ActifyTheme.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}

class _TinyStatusDot extends StatelessWidget {
  const _TinyStatusDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: ActifyTheme.neonCyan,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ActifyTheme.neonCyan.withValues(alpha: 0.45),
            blurRadius: 7,
          ),
        ],
      ),
    );
  }
}

class _CaptureOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String detail;
  const _CaptureOption({
    required this.icon,
    required this.label,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: ActifyTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ActifyTheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: ActifyTheme.electricBlue.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ActifyTheme.electricBlue.withValues(alpha: 0.18)),
            ),
            child: Icon(icon, size: 20, color: ActifyTheme.electricBlue),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            style: const TextStyle(color: ActifyTheme.textMuted, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
