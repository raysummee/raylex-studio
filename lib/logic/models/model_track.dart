import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/enums/file_type.dart';
import 'package:raylex_studio/logic/enums/record_tile_type.dart';
import 'package:raylex_studio/logic/lib/lib_record.dart';
part 'model_track.g.dart';

@HiveType(typeId: 0)
class ModelTrack {
  ModelTrack(
      {required this.name,
      required this.path,
      required this.milis,
      this.fileType = FileType.audio,
      this.record,
      this.recordType = RecordTileType.none});

  @HiveField(0)
  String name;
  @HiveField(1)
  String path;
  @HiveField(2)
  double milis;
  @HiveField(3)
  FileType fileType;
  RecordTileType recordType;
  LibRecord? record;
}
