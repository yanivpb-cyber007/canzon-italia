import 'song.dart';

class SongLibrary {
  static const List<Song> all = [sara];

  // "Sarà Perché Ti Amo" — Ricchi e Poveri
  // TODO: Verify exact lyric text against your MP3 and update lines below.
  // Add/remove SongLine entries to match your sliced audio files exactly.
  static const sara = Song(
    id: 'sara',
    title: "Sarà Perché Ti Amo",
    artist: 'Ricchi e Poveri',
    lines: [
      SongLine(
        id: 0,
        italian: "Sarà perché ti amo",
        english: "It must be because I love you",
        audioFile: 'sara_line_00',
      ),
      SongLine(
        id: 1,
        italian: "Ma stasera mi sento così",
        english: "But tonight I feel like this",
        audioFile: 'sara_line_01',
      ),
      SongLine(
        id: 2,
        italian: "Come se il mondo girasse per me",
        english: "As if the world were spinning for me",
        audioFile: 'sara_line_02',
      ),
      SongLine(
        id: 3,
        italian: "Come se tu fossi qui",
        english: "As if you were here",
        audioFile: 'sara_line_03',
      ),
      SongLine(
        id: 4,
        italian: "Sarà perché ti amo",
        english: "It must be because I love you",
        audioFile: 'sara_line_04',
      ),
      SongLine(
        id: 5,
        italian: "Ma non riesco a dormire stanotte",
        english: "But I can't sleep tonight",
        audioFile: 'sara_line_05',
      ),
      SongLine(
        id: 6,
        italian: "Penso a te e mi sembra di volare",
        english: "I think of you and it feels like flying",
        audioFile: 'sara_line_06',
      ),
      SongLine(
        id: 7,
        italian: "Tra le stelle e le nuvole",
        english: "Among the stars and clouds",
        audioFile: 'sara_line_07',
      ),
    ],
  );
}
