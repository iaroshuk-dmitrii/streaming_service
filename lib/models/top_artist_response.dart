import 'package:streaming_service/models/artist_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_artist_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TopArtistResponse {
  final List<ArtistModel> artists;
  final Meta meta;

  TopArtistResponse({
    required this.artists,
    required this.meta,
  });

  factory TopArtistResponse.fromJson(Map<String, dynamic> json) => _$TopArtistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopArtistResponseToJson(this);

  @override
  String toString() {
    return 'TopArtistResponse{topArtistList: $artists, meta: $meta}';
  }
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
