import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart' show BoxX;
import 'package:raylex_studio/logic/helpers/modelTrackHelper.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';

class ModelRecordHelper{
  Future<Box<ModelRecord>> openBox() async{
    return await Hive.openBox<ModelRecord>("records");
  }
  Box<ModelRecord> box(){
    return Hive.box<ModelRecord>("records");
  }

  ValueListenable<Box<ModelRecord>> listen(){
    return box().listenable();
  }

  ModelRecord? getAt(int index){
    return box().getAt(index);
  }

  int length(){
    return box().length;
  }

  bool isEmpty(){
    return box().isEmpty;
  }

  Future<void> add({
    required String name,
    List<ModelTrack>? tracks,
    required ModelTrack previewTrack,
    bool exported: false
  }) async{
    ModelRecord record = ModelRecord(
      name: name, 
      previewTrack: previewTrack, 
      tracks: tracks,
      exported: exported, 
      onCreated: DateTime.now(), 
      onUpdated: DateTime.now()
    );
    await box().add(record);
  }

  Future<void> update(ModelRecord record) async{
  }
}