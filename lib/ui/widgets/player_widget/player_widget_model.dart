import 'dart:async';
import 'package:flutter/material.dart';
import 'package:streaming_service/repositories/player_client.dart';

class PlayerWidgetModel extends ChangeNotifier {
  final PlayerClient _player = PlayerClient();
  int _playedTimeInMilliseconds = 0;
  int _fullTimeInMilliseconds = 0;
  PlayerState _playerState = PlayerState.unknown;
  bool _disposed = false;

  StreamSubscription<Duration?>? _durationSubscription;
  StreamSubscription<Duration>? _audioPositionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  PlayerWidgetModel();

  double get fullTimeInMilliseconds => _fullTimeInMilliseconds.toDouble();

  double get playedTimeMilliseconds => _playedTimeInMilliseconds.toDouble();

  PlayerState get playerState => _playerState;

  Future<void> setParams({required String trackUrl}) async {
    await reset();
    notifyListeners();
    _fullTimeInMilliseconds = (await _player.setUrl(trackUrl))?.inMilliseconds ?? 0;
    subscribe();
    _playerState = PlayerState.stopped;
    notifyListeners();
  }

  Future<void> playTrack() async {
    await _player.play();
  }

  Future<void> pauseTrack() async {
    await _player.pause();
  }

  Future<void> setTime(double value) async {
    _player.seek(value.toInt());
  }

  Future<void> subscribe() async {
    _durationSubscription = _player.onDurationChanged.listen((Duration? duration) {
      _fullTimeInMilliseconds = duration?.inMilliseconds ?? 0;
      notifyListeners();
    });
    _audioPositionSubscription = _player.onAudioPositionChanged.listen((Duration pos) {
      _playedTimeInMilliseconds = pos.inMilliseconds;
      notifyListeners();
    });
    _playerStateSubscription = _player.onPlayerStateChanged.listen((PlayerState state) {
      _playerState = state;
      notifyListeners();
    });
  }

  Future<void> reset() async {
    await _player.pause();
    _fullTimeInMilliseconds = 0;
    _playedTimeInMilliseconds = 0;
    _playerState = PlayerState.unknown;
    await _audioPositionSubscription?.cancel();
    await _durationSubscription?.cancel();
    await _playerStateSubscription?.cancel();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
