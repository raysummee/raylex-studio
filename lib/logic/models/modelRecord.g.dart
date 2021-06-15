// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelRecord.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelRecordAdapter extends TypeAdapter<ModelRecord> {
  @override
  final int typeId = 1;

  @override
  ModelRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelRecord(
      name: fields[0] as String,
      previewTrack: fields[4] as ModelTrack?,
      tracks: (fields[1] as List?)?.cast<ModelTrack>(),
      exported: fields[5] as bool,
      onCreated: fields[2] as DateTime,
      onUpdated: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ModelRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.tracks)
      ..writeByte(2)
      ..write(obj.onCreated)
      ..writeByte(3)
      ..write(obj.onUpdated)
      ..writeByte(4)
      ..write(obj.previewTrack)
      ..writeByte(5)
      ..write(obj.exported);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
