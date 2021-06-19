import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';
import 'package:raylex_studio/logic/helpers/modelRecordHelper.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';

class RecordController {
  Future<void> addNewTrack() async{

  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    final newFile = await sourceFile.copy(newPath);
    return newFile;
  }

  int endedTracks = 0;
  void checkAllTrackEnded(ModelRecord record){
    print("deub");
    if(record.tracks!.any((element) => element.recordType==RecordTileType.Record)){
      return;
    }
    endedTracks++;
    if(endedTracks>=record.tracks!.length){
      record.onPlayStopDispatch!();
      endedTracks = 0;
    }
  }

  bool onPlaybuttonClicked (play, ModelRecord record){
    if(record.tracks!.where((track) => track.recordType==RecordTileType.Record).length>1){
      print("one file can be recorded for now");
      return false;
    }
    record.tracks!.forEach((track) {
      print("tile type: ${track.recordType.toString()}");
      if(track.recordType==RecordTileType.Record){
        play? track.record!.recordStart(): track.record!.stopRecorder();
      }else{
        play? track.record!.play(()=> checkAllTrackEnded(record)) : track.record!.stopPlayer();
      }
    });
    return true;
  }

  Future<void> saveRecording(ModelRecord record) async{
    var basNameWithExtension = record.tracks![0].path;
    var source = File((await record.tracks![0].record!.url())!);
    var dest = (await getApplicationDocumentsDirectory()).path + "/" + basNameWithExtension;
    var file =  await moveFile(source,dest);
    record.tracks![0].path = file.path;
    await ModelRecordHelper().add(name: "New", previewTrack: record.tracks![0], tracks: record.tracks);
  }
}