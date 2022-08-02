import 'dart:async';
import 'dart:developer';
import 'package:just_audio/just_audio.dart' as player;

class PlayerClient {
  final player.AudioPlayer _audioPlayer = player.AudioPlayer();

  Future<Duration?> setUrl(String url) async {
    try {
      final duration = await _audioPlayer.setUrl(url);
      return duration;
    } catch (e) {
      log('An error opening URL: $e');
    }
    return null;
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> seek(int milliseconds) async {
    await _audioPlayer.seek(Duration(milliseconds: milliseconds));
  }

  Stream<Duration?> get onDurationChanged => _audioPlayer.durationStream;

  Stream<Duration> get onAudioPositionChanged => _audioPlayer.positionStream;

  Stream<PlayerState> get onPlayerStateChanged {
    return _audioPlayer.playerStateStream.map((event) {
      if (event.processingState == player.ProcessingState.completed) {
        pause();
        return PlayerState.completed;
      }
      if (event.playing) {
        return PlayerState.playing;
      } else {
        return PlayerState.paused;
      }
    }).cast();
  }
}

enum PlayerState {
  stopped,
  playing,
  paused,
  completed,
  unknown,
}
