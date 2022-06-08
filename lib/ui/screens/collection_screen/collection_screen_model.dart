import 'package:flutter/material.dart';
import 'package:streaming_service/models/stored_track_model.dart';
import 'package:streaming_service/repositories/local_storage_client.dart';

class CollectionScreenModel extends ChangeNotifier {
  final LocalStorageClient _localStorageClient = LocalStorageClient();
  List<StoredTrackModel> _tracks = [];
  final ScrollController scrollController = ScrollController();
  SortType _sortType = SortType.byDateDescending;
  bool playerIsShown = false;
  StoredTrackModel? _currentTrack;
  bool _disposed = false;

  List<StoredTrackModel> get tracks => _tracks;

  SortType get sortType => _sortType;

  StoredTrackModel? get currentTrack => _currentTrack;

  void getTrackList() async {
    _localStorageClient.getTasks().listen((event) async {
      _tracks = event;
      _sort();
      notifyListeners();
    });
  }

  void showPlayer(StoredTrackModel track) {
    playerIsShown = true;
    _currentTrack = track;
    notifyListeners();
  }

  void hidePlayer() {
    _currentTrack = null;
    playerIsShown = false;
    notifyListeners();
  }

  void changeSort() {
    if (_sortType == SortType.byDateAscending) {
      _sortType = SortType.byDateDescending;
    } else if (_sortType == SortType.byDateDescending) {
      _sortType = SortType.byDateAscending;
    }
    _sort();
    notifyListeners();
  }

  void deleteTrack({required String trackID}) {
    _localStorageClient.deleteTrack(trackID: trackID);
  }

  void _sort() {
    if (_sortType == SortType.byDateAscending) {
      _tracks.sort((a, b) => a.dateAdding.compareTo(b.dateAdding));
    } else if (_sortType == SortType.byDateDescending) {
      _tracks.sort((a, b) => b.dateAdding.compareTo(a.dateAdding));
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

enum SortType { byDateAscending, byDateDescending }
