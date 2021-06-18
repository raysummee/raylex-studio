import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/lib/libRecord.dart';
part 'modelTrack.g.dart';

@HiveType(typeId: 0)
class ModelTrack{
  @HiveField(0)
  String name;
  @HiveField(1)
  int path;
  @HiveField(2)
  double milis;
  LibRecord? record;
  ModelTrack({
    required this.name,
    required this.path,
    required this.milis,
    this.record
  });
}