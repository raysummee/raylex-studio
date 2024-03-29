import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/models/model_track.dart';

class ModelTrackHelper {
  Future<Box<ModelTrack>> openBox() async {
    return Hive.openBox<ModelTrack>('tracks');
  }

  Box<ModelTrack> box() {
    return Hive.box<ModelTrack>('tracks');
  }

  ModelTrack? getAt(int index) {
    return box().getAt(index);
  }

  int length() {
    return box().length;
  }

  bool isEmpty() {
    return box().isEmpty;
  }

  Future<void> addAll(List<ModelTrack> modelTracks) async {
    await box().addAll(modelTracks);
  }

  Future<void> deleteAt(int index) async {
    await box().deleteAt(index);
  }
}
