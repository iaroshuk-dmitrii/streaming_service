import 'package:json_annotation/json_annotation.dart';

part 'track_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TrackModel {
  final String type;
  final String id;
  final int index;
  final int disc;
  final String href;
  final int playbackSeconds;
  final bool isExplicit;
  final bool isStreamable;
  final bool isAvailableInHiRes;
  final String name;
  final String isrc;
  final String shortcut;
  final List<String> blurbs;
  final String artistId;
  final String artistName;
  final String albumName;
  final List<Format> formats;
  final List<Format> losslessFormats;
  final String albumId;
  final bool isAvailableInAtmos;
  final String previewURL;

  const TrackModel({
    required this.type,
    required this.id,
    required this.index,
    required this.disc,
    required this.href,
    required this.playbackSeconds,
    required this.isExplicit,
    required this.isStreamable,
    required this.isAvailableInHiRes,
    required this.name,
    required this.isrc,
    required this.shortcut,
    required this.blurbs,
    required this.artistId,
    required this.artistName,
    required this.albumName,
    required this.formats,
    required this.losslessFormats,
    required this.albumId,
    required this.isAvailableInAtmos,
    required this.previewURL,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) => _$TrackModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrackModelToJson(this);
}

@JsonSerializable()
class Format {
  final String type;
  final int bitrate;
  final String name;
  final int sampleBits;
  final int sampleRate;

  Format({
    required this.type,
    required this.bitrate,
    required this.name,
    required this.sampleBits,
    required this.sampleRate,
  });

  factory Format.fromJson(Map<String, dynamic> json) => _$FormatFromJson(json);

  Map<String, dynamic> toJson() => _$FormatToJson(this);
}
