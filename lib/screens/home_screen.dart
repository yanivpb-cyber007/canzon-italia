import 'package:flutter/material.dart';
import '../models/song_library.dart';
import 'song_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎵 CanzonItalia'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: SongLibrary.all.length,
        itemBuilder: (context, i) {
          final song = SongLibrary.all[i];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: const CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.music_note, color: Colors.white),
              ),
              title: Text(
                song.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(song.artist),
              trailing: const Icon(Icons.chevron_right, color: Colors.deepPurple),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SongDetailScreen(song: song),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
