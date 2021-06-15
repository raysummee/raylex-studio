import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';

class ModelTrackHelper{
  Future<Box<ModelTrack>> openBox() async{
    return await Hive.openBox<ModelTrack>("tracls");
  }
  Box<ModelTrack> box(){
    return Hive.box<ModelTrack>("tracks");
  }

  ModelTrack? getAt(int index){
    return box().getAt(index);
  }

  int length(){
    return box().length;
  }

  bool isEmpty(){
    return box().isEmpty;
  }

  Future<void> addAll(List<ModelTrack> modelTracks) async{
    HiveList<ModelTrack> hiveList = HiveList(ModelTrackHelper().box());
    await box().addAll(modelTracks);
    hiveList.addAll(modelTracks);
  }
}