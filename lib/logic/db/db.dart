import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raylex_studio/logic/helpers/modelRecordHelper.dart';
import 'package:raylex_studio/logic/helpers/modelTrackHelper.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';

class Db{
  Future<void> init() async{
    await Hive.initFlutter();
    registerAdapters();
    await openAllBox();
  }

  Future<void> openAllBox() async{
    await ModelRecordHelper().openBox();
    await ModelTrackHelper().openBox();
  }

  void registerAdapters(){
    Hive.registerAdapter(ModelTrackAdapter());
    Hive.registerAdapter(ModelRecordAdapter());
  }

}