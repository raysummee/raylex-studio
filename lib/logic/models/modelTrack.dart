import 'package:hive/hive.dart';
part 'modelTrack.g.dart';

@HiveType(typeId: 0)
class ModelTrack extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  int path;
  @HiveField(2)
  Duration duration;
  ModelTrack({
    required this.name,
    required this.path,
    required this.duration
  });
}