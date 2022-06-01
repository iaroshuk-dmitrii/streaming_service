import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as player;

class PlayerClient {
  final player.AudioPlayer _audioPlayer = player.AudioPlayer();

  Future<int> setUrl(String url) async {
    int result = await _audioPlayer.setUrl(url);
    if (result == 1) {
      int duration = await Future.delayed(
        const Duration(seconds: 1),
        () => _audioPlayer.getDuration(),
      );
      // +1 т.к. аудиоплеер неверно считает длительность (меньше на 1 мс)
      return duration + 1;
    }
    return 0;
  }

  Future<void> play() async {
    int result = await _audioPlayer.resume();
    if (result == 1) {
      //TODO
    }
  }

  Future<void> pause() async {
    int result = await _audioPlayer.pause();
  }

  Future<void> seek(int milliseconds) async {
    int result = await _audioPlayer.seek(Duration(milliseconds: milliseconds));
    if (result == 1) {
      //TODO
    }
  }

  Future<void> release() async {
    int result = await _audioPlayer.release();
    if (result == 1) {
      //TODO
    }
  }

  Stream<Duration> get onDurationChanged => _audioPlayer.onDurationChanged;

  Stream<Duration> get onAudioPositionChanged => _audioPlayer.onAudioPositionChanged;

  Stream<PlayerState> get onPlayerStateChanged {
    return _audioPlayer.onPlayerStateChanged.map((event) {
      switch (event) {
        case player.PlayerState.STOPPED:
          return PlayerState.stopped;
        case player.PlayerState.PLAYING:
          return PlayerState.playing;
        case player.PlayerState.PAUSED:
          return PlayerState.paused;
        case player.PlayerState.COMPLETED:
          return PlayerState.completed;
      }
    }).cast();
  }

  Stream<void> get onSeekComplete => _audioPlayer.onSeekComplete;
}

enum PlayerState {
  stopped,
  playing,
  paused,
  completed,
  unknown,
}
