import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/song.dart';
import '../providers/line_player_provider.dart';
import '../services/audio_service.dart';
import '../services/speech_service.dart';
import '../services/progress_store.dart';

class LinePlayerScreen extends StatelessWidget {
  final Song song;
  final int level;

  const LinePlayerScreen({super.key, required this.song, required this.level});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LinePlayerProvider(
        song: song,
        level: level,
        audio: AudioService(),
        speech: context.read<SpeechService>(),
        progress: context.read<ProgressStore>(),
      )..startLine(),
      child: const _LinePlayerView(),
    );
  }
}

class _LinePlayerView extends StatelessWidget {
  const _LinePlayerView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LinePlayerProvider>();
    final totalLines = vm.song.lines.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${vm.song.title} — Level ${vm.level}'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // ── Progress bar ──
            LinearProgressIndicator(
              value: (vm.currentLineIndex + 1) / totalLines,
              backgroundColor: Colors.grey[200],
              color: Colors.deepPurple,
              minHeight: 6,
            ),
            const SizedBox(height: 6),
            Text(
              'Line ${vm.currentLineIndex + 1} of $totalLines',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const Spacer(),

            // ── Italian text / translation (Level 1 only) ──
            if (vm.level == 1) ...[
              Text(
                vm.currentLine.italian,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                vm.currentLine.english,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              Text(
                '🎵 Listen carefully…',
                style: TextStyle(fontSize: 22, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],

            const Spacer(),

            // ── State-based control area ──
            _StateWidget(vm: vm),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StateWidget extends StatelessWidget {
  final LinePlayerProvider vm;

  const _StateWidget({required this.vm});

  @override
  Widget build(BuildContext context) {
    switch (vm.state) {
      case PlayerState.playingAudio:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.volume_up_rounded, size: 72, color: Colors.blue[400]),
            const SizedBox(height: 12),
            const Text('Playing…', style: TextStyle(fontSize: 18, color: Colors.blue)),
          ],
        );

      case PlayerState.listening:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _PulsingMic(),
            const SizedBox(height: 12),
            const Text('Speak now!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: vm.stopAndValidate,
              icon: const Icon(Icons.check),
              label: const Text('Done'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
            ),
          ],
        );

      case PlayerState.success:
        return const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_rounded, size: 72, color: Colors.green),
            SizedBox(height: 12),
            Text('Bravo! 🎉',
                style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green)),
          ],
        );

      case PlayerState.retry:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cancel_rounded, size: 72, color: Colors.red),
            const SizedBox(height: 12),
            const Text('Try again!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
            if (vm.lastTranscript.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'You said: "${vm.lastTranscript}"',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: vm.startLine,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
            ),
          ],
        );

      case PlayerState.complete:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎉', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 8),
            Text(
              'Level ${vm.level} Complete!',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            if (vm.level == 1) ...[
              const SizedBox(height: 8),
              const Text(
                'Level 2 is now unlocked!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              child: const Text('Back to Song', style: TextStyle(fontSize: 16)),
            ),
          ],
        );

      case PlayerState.idle:
        return const CircularProgressIndicator();
    }
  }
}

/// Mic icon that pulses while listening.
class _PulsingMic extends StatefulWidget {
  const _PulsingMic();

  @override
  State<_PulsingMic> createState() => _PulsingMicState();
}

class _PulsingMicState extends State<_PulsingMic>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: const Icon(Icons.mic_rounded, size: 72, color: Colors.red),
    );
  }
}
