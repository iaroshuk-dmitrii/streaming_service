// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
      type: json['type'] as String,
      id: json['id'] as String,
      index: json['index'] as int,
      disc: json['disc'] as int,
      href: json['href'] as String,
      playbackSeconds: json['playbackSeconds'] as int,
      isExplicit: json['isExplicit'] as bool,
      isStreamable: json['isStreamable'] as bool,
      isAvailableInHiRes: json['isAvailableInHiRes'] as bool,
      name: json['name'] as String,
      isrc: json['isrc'] as String,
      shortcut: json['shortcut'] as String,
      blurbs:
          (json['blurbs'] as List<dynamic>).map((e) => e as String).toList(),
      artistId: json['artistId'] as String,
      artistName: json['artistName'] as String,
      albumName: json['albumName'] as String,
      formats: (json['formats'] as List<dynamic>)
          .map((e) => Format.fromJson(e as Map<String, dynamic>))
          .toList(),
      losslessFormats: (json['losslessFormats'] as List<dynamic>)
          .map((e) => Format.fromJson(e as Map<String, dynamic>))
          .toList(),
      albumId: json['albumId'] as String,
      isAvailableInAtmos: json['isAvailableInAtmos'] as bool,
      previewURL: json['previewURL'] as String,
    );

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'index': instance.index,
      'disc': instance.disc,
      'href': instance.href,
      'playbackSeconds': instance.playbackSeconds,
      'isExplicit': instance.isExplicit,
      'isStreamable': instance.isStreamable,
      'isAvailableInHiRes': instance.isAvailableInHiRes,
      'name': instance.name,
      'isrc': instance.isrc,
      'shortcut': instance.shortcut,
      'blurbs': instance.blurbs,
      'artistId': instance.artistId,
      'artistName': instance.artistName,
      'albumName': instance.albumName,
      'formats': instance.formats.map((e) => e.toJson()).toList(),
      'losslessFormats':
          instance.losslessFormats.map((e) => e.toJson()).toList(),
      'albumId': instance.albumId,
      'isAvailableInAtmos': instance.isAvailableInAtmos,
      'previewURL': instance.previewURL,
    };

Format _$FormatFromJson(Map<String, dynamic> json) => Format(
      type: json['type'] as String,
      bitrate: json['bitrate'] as int,
      name: json['name'] as String,
      sampleBits: json['sampleBits'] as int,
      sampleRate: json['sampleRate'] as int,
    );

Map<String, dynamic> _$FormatToJson(Format instance) => <String, dynamic>{
      'type': instance.type,
      'bitrate': instance.bitrate,
      'name': instance.name,
      'sampleBits': instance.sampleBits,
      'sampleRate': instance.sampleRate,
    };
