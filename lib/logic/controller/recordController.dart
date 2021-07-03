import 'dart:io';
import 'package:file_picker/file_picker.dart' show FilePicker, FilePickerResult;
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raylex_studio/logic/enums/FileType.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';
import 'package:raylex_studio/logic/helpers/modelRecordHelper.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';
import 'package:raylex_studio/ux/screens/recordPanel/components/savingDialog.dart';

class RecordController {
  Future<ModelTrack?> importTrack() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result==null) return null;
    FileType fileType;
    if(
      result.files.first.extension!.toLowerCase() == 'mp3' || 
      result.files.first.extension!.toLowerCase() == 'aac' ||
      result.files.first.extension!.toLowerCase() == 'ogg'
    ){
      fileType = FileType.nonRecordable;
    }else{
      fileType = FileType.video;
    }
    var recorder =  FlutterSoundRecorder();
    await recorder.openAudioSession();
    String? newPath = await recorder.getRecordURL(path: result.files.single.name);
    recorder.closeAudioSession();
    await File(result.files.single.path!).copy(newPath!);
    await File(result.files.single.path!).delete();
    ModelTrack modelTrack = ModelTrack(
      name: result.files.single.name.split(".").reversed.elementAt(1), 
      path: result.files.single.name, 
      milis: 0,
      fileType: fileType,
    );
    return modelTrack;
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
    await sourceFile.delete();
    return newFile;
  }
  
  Future<File> saveFileToDoc(ModelTrack track) async {
    var basNameWithExtension = track.path;
    var source = File((await track.record!.url(track.path))!);
    var dest = (await getApplicationDocumentsDirectory()).path + "/" + basNameWithExtension;
    return await moveFile(source,dest);
  }

  Future<void> saveRecordingPrompt(ModelRecord record) async{
    await SavingDialog.show(saveRecording(record));
  }

  Future<void> saveRecording(ModelRecord record) async{
    await Future.delayed(Duration(milliseconds: 300));
    try{
      for(var track in record.tracks!){
        track.path = (await saveFileToDoc(track)).path;
      }
      await mergeAudio(record.tracks!);
      ModelTrack previewTrack = ModelTrack(name: "Preview", path: "${(await getApplicationDocumentsDirectory()).path}/output.aac", milis: 0);
      await ModelRecordHelper().add(name: "New", previewTrack: previewTrack, tracks: record.tracks);
    }catch (e){
      print("ERROR: $e");
    }
  }

  Future<void> mergeAudio(List<ModelTrack> tracks) async{
    final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
    List<String> fileNames = tracks.map((e) => e.path).toList();
    String fileFilters = fileNames.map((e) => "-i $e").toList().join(" ");
    _flutterFFmpeg.execute("-y $fileFilters -filter_complex amix=inputs=${fileNames.length} ${(await getApplicationDocumentsDirectory()).path}/output.aac").then((rc) => print("$fileFilters -filter complex amerge output.mp3 process exited with rc $rc"));
  }

  Future<void> deleteRecordMedia(ModelRecord? record) async{
    if(record==null||record.previewTrack==null) return;
    File(record.previewTrack!.path).exists().then((exist) {
      if(exist){
        File(record.previewTrack!.path).delete();
      }
    });
    if(record.tracks == null) return;
    record.tracks!.forEach((track) {
      File(track.path).exists().then((exist) {
        if(exist){
          File(track.path).delete();
        }
      });
    });
  }

  Future<void> deleteTrackMedia(ModelTrack? track, {bool temp:false}) async{
    if(track==null) return;
    if(temp){
      var sound = FlutterSoundRecorder();
      sound.openAudioSession();
      track.path = (await sound.getRecordURL(path: track.path))!;
    }
    File(track.path).exists().then((exist) {
      if(exist){
        File(track.path).delete();
      }
    });
  }
}