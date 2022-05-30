// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_artist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchArtistResponse _$SearchArtistResponseFromJson(
        Map<String, dynamic> json) =>
    SearchArtistResponse(
      search: Search.fromJson(json['search'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchArtistResponseToJson(
        SearchArtistResponse instance) =>
    <String, dynamic>{
      'search': instance.search.toJson(),
      'meta': instance.meta.toJson(),
    };

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      query: json['query'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'query': instance.query,
      'data': instance.data.toJson(),
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      artists: (json['artists'] as List<dynamic>)
          .map((e) => ArtistModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'artists': instance.artists.map((e) => e.toJson()).toList(),
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      totalCount: json['totalCount'] as int,
      returnedCount: json['returnedCount'] as int,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'returnedCount': instance.returnedCount,
    };
