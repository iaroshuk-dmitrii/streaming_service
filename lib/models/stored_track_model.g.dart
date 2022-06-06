// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_track_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoredTrackModelAdapter extends TypeAdapter<StoredTrackModel> {
  @override
  final int typeId = 1;

  @override
  StoredTrackModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoredTrackModel(
      id: fields[0] as String,
      name: fields[1] as String,
      artistId: fields[2] as String,
      artistName: fields[3] as String,
      albumId: fields[4] as String,
      albumName: fields[5] as String,
      previewURL: fields[6] as String,
      dateAdding: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, StoredTrackModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artistId)
      ..writeByte(3)
      ..write(obj.artistName)
      ..writeByte(4)
      ..write(obj.albumId)
      ..writeByte(5)
      ..write(obj.albumName)
      ..writeByte(6)
      ..write(obj.previewURL)
      ..writeByte(7)
      ..write(obj.dateAdding);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoredTrackModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
