import 'song.dart';

class SongLibrary {
  static const List<Song> all = [sara];

  // "Sarà Perché Ti Amo" — Ricchi e Poveri
  // Full song. Repeated lines reuse the same audio file.
  static const sara = Song(
    id: 'sara',
    title: "Sarà Perché Ti Amo",
    artist: 'Ricchi e Poveri',
    lines: [
      // Verse 1
      SongLine(id: 0,  italian: "Che confusione, sarà perché ti amo",           english: "What confusion, it must be because I love you",        audioFile: 'sara_line_00'),
      SongLine(id: 1,  italian: "È un'emozione che cresce piano piano",          english: "It's an emotion that grows slowly",                    audioFile: 'sara_line_01'),
      SongLine(id: 2,  italian: "Stringimi forte e stammi più vicino",           english: "Hold me tight and stay closer to me",                  audioFile: 'sara_line_02'),
      SongLine(id: 3,  italian: "Se ci sto bene, sarà perché ti amo",            english: "If I feel good, it must be because I love you",        audioFile: 'sara_line_03'),
      // Verse 2
      SongLine(id: 4,  italian: "Io canto al ritmo del dolce tuo respiro",       english: "I sing to the rhythm of your sweet breath",            audioFile: 'sara_line_04'),
      SongLine(id: 5,  italian: "È primavera, sarà perché ti amo",               english: "It's springtime, it must be because I love you",       audioFile: 'sara_line_05'),
      SongLine(id: 6,  italian: "Cade una stella, ma dimmi dove siamo",          english: "A star falls, but tell me where we are",               audioFile: 'sara_line_06'),
      SongLine(id: 7,  italian: "Che te ne frega, sarà perché ti amo",           english: "Who cares, it must be because I love you",             audioFile: 'sara_line_07'),
      // Chorus
      SongLine(id: 8,  italian: "E vola, vola, si sa",                           english: "And fly, fly, you know",                               audioFile: 'sara_line_08'),
      SongLine(id: 9,  italian: "Sempre più in alto si va",                      english: "Always higher we go",                                  audioFile: 'sara_line_09'),
      SongLine(id: 10, italian: "E vola, vola con me",                           english: "And fly, fly with me",                                 audioFile: 'sara_line_10'),
      SongLine(id: 11, italian: "Il mondo è matto perché",                       english: "The world is crazy because",                           audioFile: 'sara_line_11'),
      SongLine(id: 12, italian: "E se l'amore non c'è",                          english: "And if love is not there",                             audioFile: 'sara_line_12'),
      SongLine(id: 13, italian: "Basta una sola canzone",                        english: "Just one song is enough",                              audioFile: 'sara_line_13'),
      SongLine(id: 14, italian: "Per far confusione fuori e dentro di te",       english: "To create confusion inside and outside of you",        audioFile: 'sara_line_14'),
      // Verse 3
      SongLine(id: 15, italian: "Ma, dopotutto, che cosa c'è di strano?",       english: "But after all, what is so strange?",                   audioFile: 'sara_line_15'),
      SongLine(id: 16, italian: "È una canzone, sarà perché ti amo",             english: "It's a song, it must be because I love you",           audioFile: 'sara_line_16'),
      SongLine(id: 17, italian: "Se cade il mondo, allora ci spostiamo",         english: "If the world falls, then we'll move",                  audioFile: 'sara_line_17'),
      SongLine(id: 18, italian: "Se cade il mondo, sarà perché ti amo",          english: "If the world falls, it must be because I love you",    audioFile: 'sara_line_18'),
      // Verse 4
      SongLine(id: 19, italian: "Stringimi forte e stammi più vicino",           english: "Hold me tight and stay closer to me",                  audioFile: 'sara_line_02'),
      SongLine(id: 20, italian: "È così bello che non mi sembra vero",           english: "It's so beautiful it doesn't seem real",               audioFile: 'sara_line_19'),
      SongLine(id: 21, italian: "Se il mondo è matto, che cosa c'è di strano?", english: "If the world is crazy, what is so strange?",           audioFile: 'sara_line_20'),
      SongLine(id: 22, italian: "Matto per matto, almeno noi ci amiamo",         english: "Crazy for crazy, at least we love each other",         audioFile: 'sara_line_21'),
      // Final chorus variation
      SongLine(id: 23, italian: "E vola, vola, si va",                           english: "And fly, fly, let's go",                               audioFile: 'sara_line_22'),
      SongLine(id: 24, italian: "Sarà perché ti amo",                            english: "It must be because I love you",                        audioFile: 'sara_line_23'),
      SongLine(id: 25, italian: "E vola, vola con me",                           english: "And fly, fly with me",                                 audioFile: 'sara_line_10'),
      SongLine(id: 26, italian: "E stammi più vicino",                           english: "And stay closer to me",                                audioFile: 'sara_line_24'),
      SongLine(id: 27, italian: "E se l'amore non c'è",                          english: "And if love is not there",                             audioFile: 'sara_line_12'),
      SongLine(id: 28, italian: "Ma dimmi dove siamo",                           english: "But tell me where we are",                             audioFile: 'sara_line_25'),
      SongLine(id: 29, italian: "Che confusione, sarà perché ti amo",            english: "What confusion, it must be because I love you",        audioFile: 'sara_line_00'),
    ],
  );
}
