import 'package:flutter/material.dart';
import 'package:streaming_service/models/artist_model.dart';
import 'package:streaming_service/models/artist_top_tracks_response.dart';
import 'package:streaming_service/models/stored_track_model.dart';
import 'package:streaming_service/models/track_model.dart';
import 'package:streaming_service/repositories/api_client.dart';
import 'package:streaming_service/repositories/local_storage_client.dart';

class ArtistsAboutScreenModel extends ChangeNotifier {
  final ArtistModel artist;
  final ApiClient _apiClient = ApiClient();
  final LocalStorageClient _localStorageClient = LocalStorageClient();
  final List<TrackModel> _tracks = [];
  int _maxLength = 1;
  bool _isLoading = false;
  bool playerIsShown = false;
  TrackModel? _currentTrack;
  bool _disposed = false;

  ArtistsAboutScreenModel({required this.artist});

  List<TrackModel> get tracks => _tracks;

  bool get isLoading => _isLoading;

  TrackModel? get currentTrack => _currentTrack;

  Future<void> getTrackList() async {
    if (_tracks.length <= _maxLength - 1 && !_isLoading) {
      _isLoading = true;
      notifyListeners();
      ArtistTopTracksResponse artistTopTracksResponse =
          await _apiClient.getTopArtistTracks(artistId: artist.id, limit: 5, offset: _tracks.length);
      _tracks.addAll(artistTopTracksResponse.tracks);
      _maxLength = artistTopTracksResponse.meta.totalCount;
      _isLoading = false;
      notifyListeners();
    }
  }

  void showPlayer(TrackModel track) {
    playerIsShown = true;
    _currentTrack = track;
    notifyListeners();
  }

  void hidePlayer() {
    _currentTrack = null;
    playerIsShown = false;
    notifyListeners();
  }

  Future<void> addToCollection() async {
    final cTrack = _currentTrack;
    if (cTrack != null) {
      StoredTrackModel track = StoredTrackModel.fromTrackModel(model: cTrack, dateAdding: DateTime.now());
      await _localStorageClient.addTrack(track: track);
    }
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
