import 'package:flutter/material.dart';
import 'package:streaming_service/models/artist_model.dart';
import 'package:streaming_service/models/search_artist_response.dart';
import 'package:streaming_service/repositories/api_client.dart';

class SearchScreenModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  final List<ArtistModel> _artists = [];
  final ScrollController scrollController = ScrollController();
  int _maxLength = 1;
  bool _isLoading = false;
  String _searchString = '';

  List<ArtistModel> get artists => _artists;

  void changeSearchString(String searchString) {
    if (_searchString != searchString) {
      _searchString = searchString;
      clearSearch();
      notifyListeners();
    }
  }

  void clearSearch() {
    _artists.clear();
    notifyListeners();
  }

  Future<void> searchArtistList() async {
    if (_artists.length <= _maxLength - 1 && !_isLoading && _searchString.isNotEmpty) {
      _isLoading = true;
      SearchArtistResponse searchArtistResponse = await _apiClient.searchArtist(
        searchString: _searchString,
        limit: 20,
        offset: _artists.length,
      );
      _artists.addAll(searchArtistResponse.search.data.artists);
      _maxLength = searchArtistResponse.meta.totalCount;
      _isLoading = false;
      notifyListeners();
    }
  }
}
