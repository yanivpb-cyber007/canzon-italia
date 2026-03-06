import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioService {
  AudioPlayer? _player;
  StreamSubscription? _subscription;

  Future<void> playLine(String audioFile, {VoidCallback? onComplete}) async {
    // Cancel any previous playback
    await _subscription?.cancel();
    await _player?.stop();
    _player?.dispose();

    _player = AudioPlayer();

    try {
      await _player!.setAsset('assets/audio/$audioFile.mp3');

      _subscription = _player!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          onComplete?.call();
        }
      });

      await _player!.play();
    } catch (e) {
      debugPrint('AudioService: error playing $audioFile — $e');
      onComplete?.call(); // never block the flow if audio fails
    }
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    await _player?.stop();
  }

  void dispose() {
    _subscription?.cancel();
    _player?.dispose();
    _player = null;
  }
}
