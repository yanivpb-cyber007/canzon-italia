class Song {
  final String id;
  final String title;
  final String artist;
  final List<SongLine> lines;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.lines,
  });
}

class SongLine {
  final int id;
  final String italian;
  final String english;
  final String audioFile; // filename without extension, e.g. "sara_line_00"

  const SongLine({
    required this.id,
    required this.italian,
    required this.english,
    required this.audioFile,
  });
}
