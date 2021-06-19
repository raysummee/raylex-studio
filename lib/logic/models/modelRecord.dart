import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';
part 'modelRecord.g.dart';

@HiveType(typeId: 1)
class ModelRecord{
  @HiveField(0)
  String name;
  @HiveField(1)
  List<ModelTrack>? tracks;
  @HiveField(2)
  DateTime onCreated;
  @HiveField(3)
  DateTime onUpdated;
  @HiveField(4)
  ModelTrack? previewTrack;
  @HiveField(5)
  bool exported;


  void Function()? onPlayingDispatch;
  void Function()? onPlayStopDispatch;

  ModelRecord({
    required this.name,
    this.previewTrack,
    this.tracks,
    required this.exported,
    required this.onCreated,
    required this.onUpdated
  });
}