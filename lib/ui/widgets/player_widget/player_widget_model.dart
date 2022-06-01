import 'package:flutter/material.dart';

class PlayerWidgetModel extends ChangeNotifier {
  bool isPlaying = false;
  double _playedTimeSeconds = 0.0;
  double _playbackSeconds = 0.0;
  String _trackUrl = '';

  PlayerWidgetModel();

  double get playbackSeconds => _playbackSeconds;

  double get playedTimeSeconds => _playedTimeSeconds;

  void setParams({
    required double playbackSeconds,
    required String trackUrl,
  }) {
    _playbackSeconds = playbackSeconds;
    _trackUrl = trackUrl;
  }

  void playTrack() {
    print('playTrack');
    isPlaying = true;
    print(isPlaying);
    notifyListeners();
  }

  void pauseTrack() {
    print('pauseTrack');
    isPlaying = false;
    notifyListeners();
  }

  Future<void> setTime(double value) async {
    print('setTime $value');
    _playedTimeSeconds = value;
    notifyListeners();
  }
}
