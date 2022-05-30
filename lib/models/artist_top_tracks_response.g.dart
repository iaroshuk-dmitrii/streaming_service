// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_top_tracks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistTopTracksResponse _$ArtistTopTracksResponseFromJson(
        Map<String, dynamic> json) =>
    ArtistTopTracksResponse(
      tracks: (json['tracks'] as List<dynamic>)
          .map((e) => TrackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtistTopTracksResponseToJson(
        ArtistTopTracksResponse instance) =>
    <String, dynamic>{
      'tracks': instance.tracks.map((e) => e.toJson()).toList(),
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
