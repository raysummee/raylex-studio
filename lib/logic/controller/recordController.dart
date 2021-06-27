import 'dart:io';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';
import 'package:raylex_studio/logic/helpers/modelRecordHelper.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';

class RecordController {
  Future<void> addNewTrack() async{

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
        play? track.record!.recordStart(track.path): track.record!.stopRecorder();
      }else{
        play? track.record!.play(track.path,()=> checkAllTrackEnded(record)) : track.record!.stopPlayer();
      }
    });
    return true;
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    final newFile = await sourceFile.copy(newPath);
    return newFile;
  }
  
  Future<File> saveFileToDoc(ModelTrack track) async {
    var basNameWithExtension = track.path + ".aac";
    var source = File((await track.record!.url(track.path+".acc"))!);
    var dest = (await getApplicationDocumentsDirectory()).path + "/" + basNameWithExtension;
    return await moveFile(source,dest);
  }

  Future<void> saveRecording(ModelRecord record) async{
    for(var track in record.tracks!){
      track.path = (await saveFileToDoc(track)).path;
    }
    await mergeAudio(record.tracks!);
    ModelTrack previewTrack = ModelTrack(name: "Preview", path: "${(await getApplicationDocumentsDirectory()).path}/output.aac", milis: 0);
    await ModelRecordHelper().add(name: "New", previewTrack: previewTrack, tracks: record.tracks);
  }

  Future<void> mergeAudio(List<ModelTrack> tracks) async{
    final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
    List<String> fileNames = tracks.map((e) => e.path).toList();
    String fileFilters = fileNames.map((e) => "-i $e").toList().join(" ");
    _flutterFFmpeg.execute("-y $fileFilters -filter_complex amix=inputs=${fileNames.length} ${(await getApplicationDocumentsDirectory()).path}/output.aac").then((rc) => print("$fileFilters -filter complex amerge output.mp3 process exited with rc $rc"));
  }

}