import 'package:hive/hive.dart';
part 'file_type.g.dart';

@HiveType(typeId: 3)
enum FileType {
  @HiveField(0)
  audio,
  @HiveField(2)
  video,
  @HiveField(3)
  nonRecordable
}
