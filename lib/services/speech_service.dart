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

  /// Returns true if the spoken text matches the expected Italian line.
  /// Strips punctuation and is case-insensitive.
  bool isMatch(String spoken, String expected) {
    String normalize(String s) => s
        .toLowerCase()
        .replaceAll(RegExp(r"[^\w\s]", unicode: true), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return normalize(spoken) == normalize(expected);
  }
}
