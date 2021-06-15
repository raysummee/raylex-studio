// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelTrack.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelTrackAdapter extends TypeAdapter<ModelTrack> {
  @override
  final int typeId = 0;

  @override
  ModelTrack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelTrack(
      name: fields[0] as String,
      path: fields[1] as int,
      duration: fields[2] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, ModelTrack obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelTrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
