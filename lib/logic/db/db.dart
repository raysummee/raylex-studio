import 'package:hive_flutter/hive_flutter.dart';
import 'package:raylex_studio/logic/enums/file_type.dart';
import 'package:raylex_studio/logic/helpers/model_record_helper.dart';
import 'package:raylex_studio/logic/helpers/model_track_helper.dart';
import 'package:raylex_studio/logic/models/model_record.dart';
import 'package:raylex_studio/logic/models/model_track.dart';

class Db {
  Future<void> init() async {
    await Hive.initFlutter();
    registerAdapters();
    await openAllBox();
  }

  Future<void> openAllBox() async {
    await ModelRecordHelper().openBox();
    await ModelTrackHelper().openBox();
  }

  void registerAdapters() {
    Hive.registerAdapter(ModelTrackAdapter());
    Hive.registerAdapter(ModelRecordAdapter());
    Hive.registerAdapter(FileTypeAdapter());
  }
}
