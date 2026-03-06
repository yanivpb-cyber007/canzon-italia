import 'package:flutter/foundation.dart';
import '../models/song.dart';
import '../services/audio_service.dart';
import '../services/speech_service.dart';
import '../services/progress_store.dart';

enum PlayerState { idle, playingAudio, listening, success, retry, complete }

class LinePlayerProvider extends ChangeNotifier {
  final Song song;
  final int level;
  final AudioService _audio;
  final SpeechService _speech;
  final ProgressStore _progress;

  int currentLineIndex = 0;
  PlayerState state = PlayerState.idle;
  String lastTranscript = '';

  LinePlayerProvider({
    required this.song,
    required this.level,
    required AudioService audio,
    required SpeechService speech,
    required ProgressStore progress,
  })  : _audio = audio,
        _speech = speech,
        _progress = progress;

  SongLine get currentLine => song.lines[currentLineIndex];

  Future<void> startLine() async {
    state = PlayerState.playingAudio;
    lastTranscript = '';
    notifyListeners();

    await _audio.playLine(currentLine.audioFile, onComplete: _onAudioFinished);
  }

  void _onAudioFinished() {
    state = PlayerState.listening;
    notifyListeners();
    _speech.startListening(onResult: _handleResult);
  }

  void stopAndValidate() {
    _speech.stopListening();
    // stopListening will trigger the finalResult callback, which calls _handleResult.
    // If the user taps Done before any speech detected, treat as empty.
  }

  void _handleResult(String transcript) {
    lastTranscript = transcript;
    if (_speech.isMatch(transcript, currentLine.italian)) {
      _advance();
    } else {
      state = PlayerState.retry;
      notifyListeners();
    }
  }

  Future<void> _advance() async {
    await _progress.markLineComplete(song.id, level, currentLine.id);
    state = PlayerState.success;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1200));

    if (currentLineIndex + 1 < song.lines.length) {
      currentLineIndex++;
      await startLine();
    } else {
      await _progress.setLevelComplete(song.id, level);
      state = PlayerState.complete;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _audio.dispose();
    super.dispose();
  }
}
