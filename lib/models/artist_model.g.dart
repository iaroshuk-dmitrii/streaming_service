// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistModel _$ArtistModelFromJson(Map<String, dynamic> json) => ArtistModel(
      type: json['type'] as String,
      id: json['id'] as String,
      href: json['href'] as String,
      name: json['name'] as String,
      amg: json['amg'] as String?,
      shortcut: json['shortcut'] as String,
      blurbs:
          (json['blurbs'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      bios: (json['bios'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : ArtistBio.fromJson(e as Map<String, dynamic>))
          .toList(),
      albumGroups:
          AlbumGroups.fromJson(json['albumGroups'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtistModelToJson(ArtistModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'href': instance.href,
      'name': instance.name,
      'amg': instance.amg,
      'shortcut': instance.shortcut,
      'blurbs': instance.blurbs,
      'bios': instance.bios?.map((e) => e?.toJson()).toList(),
      'albumGroups': instance.albumGroups.toJson(),
    };

ArtistBio _$ArtistBioFromJson(Map<String, dynamic> json) => ArtistBio(
      title: json['title'] as String,
      author: json['author'] as String,
      publishDate: json['publishDate'] as String,
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$ArtistBioToJson(ArtistBio instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'publishDate': instance.publishDate,
      'bio': instance.bio,
    };

AlbumGroups _$AlbumGroupsFromJson(Map<String, dynamic> json) => AlbumGroups(
      main: (json['main'] as List<dynamic>?)?.map((e) => e as String).toList(),
      singlesAndEps: (json['singlesAndEps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      compilations: (json['compilations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      others:
          (json['others'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AlbumGroupsToJson(AlbumGroups instance) =>
    <String, dynamic>{
      'main': instance.main,
      'singlesAndEps': instance.singlesAndEps,
      'compilations': instance.compilations,
      'others': instance.others,
    };
