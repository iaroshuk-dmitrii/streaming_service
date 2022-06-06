import 'package:hive/hive.dart';
import 'package:streaming_service/models/track_model.dart';

part 'stored_track_model.g.dart';

@HiveType(typeId: 1)
class StoredTrackModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String artistId;

  @HiveField(3)
  String artistName;

  @HiveField(4)
  String albumId;

  @HiveField(5)
  String albumName;

  @HiveField(6)
  String previewURL;

  @HiveField(7)
  DateTime dateAdding;

  StoredTrackModel({
    required this.id,
    required this.name,
    required this.artistId,
    required this.artistName,
    required this.albumId,
    required this.albumName,
    required this.previewURL,
    required this.dateAdding,
  });

  factory StoredTrackModel.fromTrackModel({required TrackModel model, required DateTime dateAdding}) {
    return StoredTrackModel(
      id: model.id,
      name: model.name,
      artistId: model.artistId,
      artistName: model.artistName,
      albumId: model.albumId,
      albumName: model.albumName,
      previewURL: model.previewURL,
      dateAdding: dateAdding,
    );
  }

  @override
  String toString() {
    return 'StoredTrackModel{id: $id, name: $name, artistId: $artistId, artistName: $artistName, albumId: $albumId, albumName: $albumName, previewURL: $previewURL, dateAdding: $dateAdding}';
  }
}
