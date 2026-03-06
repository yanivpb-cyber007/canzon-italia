import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/song.dart';
import '../services/progress_store.dart';
import 'line_player_screen.dart';

class SongDetailScreen extends StatelessWidget {
  final Song song;

  const SongDetailScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressStore>();
    final level2Locked = !progress.isLevelComplete(song.id, 1);

    final l1Done = progress.completedLineCount(song.id, 1);
    final l2Done = progress.completedLineCount(song.id, 2);
    final total = song.lines.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(song.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.artist,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '${song.lines.length} lines to learn',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 32),
            _LevelCard(
              song: song,
              level: 1,
              isLocked: false,
              doneCount: l1Done,
              totalCount: total,
            ),
            const SizedBox(height: 16),
            _LevelCard(
              song: song,
              level: 2,
              isLocked: level2Locked,
              doneCount: l2Done,
              totalCount: total,
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final Song song;
  final int level;
  final bool isLocked;
  final int doneCount;
  final int totalCount;

  const _LevelCard({
    required this.song,
    required this.level,
    required this.isLocked,
    required this.doneCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = level == 1 ? 'Audio + Italian text + Translation' : 'Audio only — no text';
    final progress = doneCount / totalCount;

    return Card(
      elevation: isLocked ? 1 : 3,
      color: isLocked ? Colors.grey[100] : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isLocked
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LinePlayerScreen(song: song, level: level),
                  ),
                ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isLocked ? Icons.lock_outline : Icons.music_note,
                    color: isLocked ? Colors.grey : Colors.deepPurple,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Level $level',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: isLocked ? Colors.grey : Colors.black87,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: isLocked ? Colors.grey : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLocked)
                    const Icon(Icons.play_circle_fill,
                        color: Colors.deepPurple, size: 32),
                ],
              ),
              if (!isLocked) ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 4),
                Text(
                  '$doneCount / $totalCount lines completed',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
              if (isLocked)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Complete Level 1 to unlock',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
