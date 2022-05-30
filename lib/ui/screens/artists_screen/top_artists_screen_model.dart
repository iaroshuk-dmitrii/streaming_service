import 'package:flutter/material.dart';
import 'package:streaming_service/models/artist_model.dart';
import 'package:streaming_service/models/top_artist_response.dart';
import 'package:streaming_service/repositories/api_client.dart';

class TopArtistsScreenModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  final List<ArtistModel> _artists = [];
  final ScrollController scrollController = ScrollController();
  int _maxLength = 1;
  bool _isLoading = false;

  List<ArtistModel> get artists => _artists;

  Future<void> getArtistList() async {
    if (_artists.length <= _maxLength - 1 && !_isLoading) {
      _isLoading = true;
      TopArtistResponse topArtistResponse = await _apiClient.getTopArtist(limit: 20, offset: _artists.length);
      _artists.addAll(topArtistResponse.artists);
      _maxLength = topArtistResponse.meta.totalCount;
      _isLoading = false;
      notifyListeners();
    }
  }
}
