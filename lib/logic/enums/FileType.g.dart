// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FileType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileTypeAdapter extends TypeAdapter<FileType> {
  @override
  final int typeId = 3;

  @override
  FileType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FileType.audio;
      case 2:
        return FileType.video;
      case 3:
        return FileType.nonRecordable;
      default:
        return FileType.audio;
    }
  }

  @override
  void write(BinaryWriter writer, FileType obj) {
    switch (obj) {
      case FileType.audio:
        writer.writeByte(0);
        break;
      case FileType.video:
        writer.writeByte(2);
        break;
      case FileType.nonRecordable:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
