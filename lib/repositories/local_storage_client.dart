import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:streaming_service/configuration/configuration.dart';
import 'package:streaming_service/models/stored_track_model.dart';

class LocalStorageClient {
  //ключем будет ID трека
  final _box = Hive.box<StoredTrackModel>(Configuration.boxName);

  static Future<void> init() async {
    Directory? directory;
    try {
      directory = await getApplicationDocumentsDirectory();
    } catch (e) {
      log('Directory error: $e');
    }
    Hive
      ..init(directory?.path)
      ..registerAdapter(StoredTrackModelAdapter());
    await Hive.openBox<StoredTrackModel>(Configuration.boxName);
  }

  static close() {
    Hive.close();
  }

  Future<void> addTrack({required StoredTrackModel track}) async {
    await _box.put(track.id, track);
  }

  void clearAll() {
    _box.clear();
  }

  void deleteTrack({required String trackID}) {
    _box.delete(trackID);
  }

  Stream<List<StoredTrackModel>> getTasks() => _box
      .watch()
      .map((event) {
        List<StoredTrackModel> tracks = _box.values.toList();
        return tracks;
      })
      .startWith(_box.values.toList())
      .cast();
}
