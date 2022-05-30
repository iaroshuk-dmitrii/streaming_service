import 'package:streaming_service/models/artist_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_artist_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchArtistResponse {
  final Search search;
  final Meta meta;

  SearchArtistResponse({
    required this.search,
    required this.meta,
  });

  factory SearchArtistResponse.fromJson(Map<String, dynamic> json) => _$SearchArtistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchArtistResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Search {
  final String query;
  final Data data;

  const Search({
    required this.query,
    required this.data,
  });

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Data {
  final List<ArtistModel> artists;

  const Data({
    required this.artists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
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
