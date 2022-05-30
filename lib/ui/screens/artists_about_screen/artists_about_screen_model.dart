import 'package:flutter/material.dart';
import 'package:streaming_service/models/artist_model.dart';
import 'package:streaming_service/models/artist_top_tracks_response.dart';
import 'package:streaming_service/models/track_model.dart';
import 'package:streaming_service/repositories/api_client.dart';

class ArtistsAboutScreenModel extends ChangeNotifier {
  final ArtistModel artist;
  final ApiClient _apiClient = ApiClient();
  final List<TrackModel> _tracks = [];
  int _maxLength = 1;
  bool _isLoading = false;

  ArtistsAboutScreenModel({required this.artist});

  List<TrackModel> get tracks => _tracks;

  bool get isLoading => _isLoading;

  Future<void> getTrackList() async {
    print('getTrackList');
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

  Future<void> playTrack(TrackModel track) async {
    print('playTrack ${track.name}');
  }
}
