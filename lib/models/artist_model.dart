import 'package:json_annotation/json_annotation.dart';

part 'artist_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ArtistModel {
  final String type;
  final String id;
  final String href;
  final String name;
  final String? amg;
  final String shortcut;
  final List<String?>? blurbs;
  final List<ArtistBio?>? bios;
  final AlbumGroups albumGroups;

  ArtistModel({
    required this.type,
    required this.id,
    required this.href,
    required this.name,
    required this.amg,
    required this.shortcut,
    required this.blurbs,
    required this.bios,
    required this.albumGroups,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) => _$ArtistModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);

  @override
  String toString() {
    return 'ArtistModel{type: $type, id: $id, href: $href, name: $name, amg: $amg, shortcut: $shortcut, blurbs: $blurbs, bios: $bios, albumGroups: $albumGroups}';
  }
}

@JsonSerializable(explicitToJson: true)
class ArtistBio {
  final String title;
  final String author;
  final String publishDate;
  final String bio;

  ArtistBio({
    required this.title,
    required this.author,
    required this.publishDate,
    required this.bio,
  });

  factory ArtistBio.fromJson(Map<String, dynamic> json) => _$ArtistBioFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistBioToJson(this);

  @override
  String toString() {
    return 'ArtistBio{title: $title, author: $author, publishDate: $publishDate, bio: $bio}';
  }
}

@JsonSerializable(explicitToJson: true)
class AlbumGroups {
  final List<String>? main;
  final List<String>? singlesAndEps;
  final List<String>? compilations;
  final List<String>? others;

  AlbumGroups({
    this.main,
    this.singlesAndEps,
    this.compilations,
    this.others,
  });
  factory AlbumGroups.fromJson(Map<String, dynamic> json) => _$AlbumGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumGroupsToJson(this);
}
