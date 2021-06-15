import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';
part 'modelRecord.g.dart';

@HiveType(typeId: 1)
class ModelRecord extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  HiveList<ModelTrack>? tracks;
  @HiveField(2)
  DateTime onCreated;
  @HiveField(3)
  DateTime onUpdated;
  @HiveField(4)
  ModelTrack previewTrack;
  @HiveField(5)
  bool exported;

  ModelRecord({
    required this.name,
    required this.previewTrack,
    required this.exported,
    required this.onCreated,
    required this.onUpdated
  });
}