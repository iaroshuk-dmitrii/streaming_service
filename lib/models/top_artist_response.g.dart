// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_artist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopArtistResponse _$TopArtistResponseFromJson(Map<String, dynamic> json) =>
    TopArtistResponse(
      artists: (json['artists'] as List<dynamic>)
          .map((e) => ArtistModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TopArtistResponseToJson(TopArtistResponse instance) =>
    <String, dynamic>{
      'artists': instance.artists.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      totalCount: json['totalCount'] as int,
      returnedCount: json['returnedCount'] as int,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'returnedCount': instance.returnedCount,
    };
