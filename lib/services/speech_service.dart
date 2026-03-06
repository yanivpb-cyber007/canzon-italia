import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _stt = SpeechToText();
  bool _initialized = false;

  bool get isAvailable => _initialized;

  Future<bool> init() async {
    _initialized = await _stt.initialize(
      onError: (error) => debugPrint('SpeechService error: ${error.errorMsg}'),
      onStatus: (status) => debugPrint('SpeechService status: $status'),
    );
    return _initialized;
  }

  Future<void> startListening({required Function(String transcript) onResult}) async {
    if (!_initialized) {
      debugPrint('SpeechService: not initialized, skipping listen');
      return;
    }

    await _stt.listen(
      localeId: 'it_IT',
      onResult: (result) {
        if (result.finalResult) {
          onResult(result.recognizedWords);
        }
      },
      listenFor: const Duration(seconds: 15),
      pauseFor: const Duration(seconds: 3),
    );
  }

  Future<void> stopListening() async {
    await _stt.stop();
  }

  /// Returns true if the spoken text is a close enough match to the expected line.
  /// Uses word-overlap scoring: passes if 70%+ of expected words are heard.
  /// This is forgiving of minor mispronunciations and dropped words.
  bool isMatch(String spoken, String expected) {
    final spokenWords = _words(spoken);
    final expectedWords = _words(expected);

    if (spokenWords.isEmpty) return false;

    // Count how many expected words appear in the spoken text
    int matches = 0;
    for (final word in expectedWords) {
      if (spokenWords.contains(word)) matches++;
    }

    final score = matches / expectedWords.length;
    debugPrint('SpeechService match: $score ($matches/${expectedWords.length}) spoken="$spoken"');
    return score >= 0.70; // 70% threshold — forgiving but not too easy
  }

  List<String> _words(String s) {
    return s
        .toLowerCase()
        .replaceAll(RegExp(r"[^\w\s]", unicode: true), '')
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
  }
}
