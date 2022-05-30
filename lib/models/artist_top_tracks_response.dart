import 'package:json_annotation/json_annotation.dart';
import 'package:streaming_service/models/track_model.dart';

part 'artist_top_tracks_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ArtistTopTracksResponse {
  List<TrackModel> tracks;
  Meta meta;

  ArtistTopTracksResponse({
    required this.tracks,
    required this.meta,
  });

  factory ArtistTopTracksResponse.fromJson(Map<String, dynamic> json) => _$ArtistTopTracksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistTopTracksResponseToJson(this);
}

@JsonSerializable()
class Meta {
  final int totalCount;
  final int returnedCount;

  Meta({
    required this.totalCount,
    required this.returnedCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);

  @override
  String toString() {
    return 'Meta{totalCount: $totalCount, returnedCount: $returnedCount}';
  }
}
