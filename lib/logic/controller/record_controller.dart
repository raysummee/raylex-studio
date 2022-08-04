import 'dart:io';
import 'package:file_picker/file_picker.dart' show FilePicker, FilePickerResult;
import 'package:flutter/foundation.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raylex_studio/logic/enums/file_type.dart';
import 'package:raylex_studio/logic/enums/record_tile_type.dart';
import 'package:raylex_studio/logic/helpers/model_record_helper.dart';
import 'package:raylex_studio/logic/models/model_record.dart';
import 'package:raylex_studio/logic/models/model_track.dart';
import 'package:raylex_studio/ux/screens/recordPanel/components/saving_dialog.dart';

class RecordController {
  Future<ModelTrack?> importTrack() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }
    FileType fileType;
    if (result.files.first.extension!.toLowerCase() == 'mp3' ||
        result.files.first.extension!.toLowerCase() == 'aac' ||
        result.files.first.extension!.toLowerCase() == 'ogg') {
      fileType = FileType.nonRecordable;
    } else {
      fileType = FileType.video;
    }
    final recorder = FlutterSoundRecorder();
    await recorder.openAudioSession();
    final String? newPath =
        await recorder.getRecordURL(path: result.files.single.name);
    recorder.closeAudioSession();
    await File(result.files.single.path!).copy(newPath!);
    await File(result.files.single.path!).delete();
    final tracknameList =
        result.files.single.name.split('/').reversed.elementAt(0).split('.');
    tracknameList.removeLast();
    final trackName = tracknameList.join('.');
    final ModelTrack modelTrack = ModelTrack(
      name: trackName,
      path: result.files.single.name,
      milis: 0,
      fileType: fileType,
    );
    return modelTrack;
  }

  int endedTracks = 0;
  void checkAllTrackEnded(ModelRecord record) {
    debugPrint('deub');
    if (record.tracks!
        .any((element) => element.recordType == RecordTileType.record)) {
      return;
    }
    endedTracks++;
    if (endedTracks >= record.tracks!.length) {
      record.onPlayStopDispatch!();
      endedTracks = 0;
    }
  }

  bool onPlaybuttonClicked(bool play, ModelRecord record) {
    if (record.tracks!
            .where((track) => track.recordType == RecordTileType.record)
            .length >
        1) {
      debugPrint('one file can be recorded for now');
      Fluttertoast.showToast(
        msg:
            'Failed recording multiple files. \nPlease select single track for recording',
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    }
    for (final track in record.tracks!) {
      debugPrint('tile type: ${track.recordType.toString()}');
      if (track.recordType == RecordTileType.record) {
        play
            ? track.record!.recordStart(track.path)
            : track.record!.stopRecorder();
      } else {
        play
            ? track.record!.play(track.path, () => checkAllTrackEnded(record))
            : track.record!.stopPlayer();
      }
    }
    return true;
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    await File(newPath).create(recursive: true);
    final newFile = await sourceFile.copy(newPath);
    await sourceFile.delete();
    return newFile;
  }

  Future<File> saveFileToDoc(
      ModelTrack track, String recordName, DateTime now) async {
    final basNameWithExtension = track.path.split('/').last;
    var source = File((await track.record!.url(basNameWithExtension))!);
    if (track.path.split('/').length > 2) {
      source = File(track.path);
    }
    final dest =
        '${(await getApplicationDocumentsDirectory()).path}/${DateFormat('ddMMyyyy-hhmmss').format(now)}/$basNameWithExtension';
    return moveFile(source, dest);
  }

  Future<void> saveRecordingPrompt(ModelRecord record,
      {bool update = false}) async {
    if (update) {
      return SavingDialog.show(updateRecording(record));
    }
    return SavingDialog.show(saveRecording(record));
  }

  String generateRecordNameUsingCount() {
    final int lastIndex = ModelRecordHelper().length() - 1;
    if (lastIndex < 0) {
      return 'New Record 1';
    }
    final String lastRecordName = ModelRecordHelper().getAt(lastIndex)!.name;
    final int? lastRecordCount =
        int.tryParse(lastRecordName.replaceAll('New Record', ''));
    if (lastRecordCount == null) {
      return 'New Record 1';
    }
    final String newRecordName = 'New Record ${lastRecordCount + 1}';
    return newRecordName;
  }

  Future<bool> saveRecording(ModelRecord record) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      for (final track in record.tracks!) {
        track.path =
            (await saveFileToDoc(track, record.name, record.onCreated)).path;
      }
      final File mergeFile = await mergeAudio(record.tracks!, record.onCreated);
      final ModelTrack previewTrack =
          ModelTrack(name: 'Preview', path: mergeFile.path, milis: 0);

      await ModelRecordHelper().add(
          name: generateRecordNameUsingCount(),
          previewTrack: previewTrack,
          tracks: record.tracks);
    } catch (e) {
      debugPrint('ERROR: $e');
      return false;
    }
    return true;
  }

  Future<bool> updateRecording(ModelRecord record) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      for (final track in record.tracks!) {
        track.path =
            (await saveFileToDoc(track, record.name, record.onCreated)).path;
      }
      final File mergeFile = await mergeAudio(record.tracks!, record.onCreated);
      final ModelTrack previewTrack =
          ModelTrack(name: 'Preview', path: mergeFile.path, milis: 0);
      record.previewTrack = previewTrack;
      record.onUpdated = DateTime.now();

      await ModelRecordHelper().update(record);
    } catch (e) {
      debugPrint('ERROR: $e');
      return false;
    }
    return true;
  }

  Future<File> mergeAudio(List<ModelTrack> tracks, DateTime now) async {
    final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
    final List<String> fileNames = tracks.map((e) => '"${e.path}"').toList();
    final String fileFilters = fileNames.map((e) => '-i $e').toList().join(' ');
    await flutterFFmpeg
        .execute(
            '-y $fileFilters -filter_complex amix=inputs=${fileNames.length},volume=${fileNames.length} ${(await getApplicationDocumentsDirectory()).path}/output.aac')
        .then((rc) => debugPrint(
            '$fileFilters -filter complex amerge output.mp3 process exited with rc $rc'));
    final dest =
        '${(await getApplicationDocumentsDirectory()).path}/${DateFormat('ddMMyyyy-hhmmss').format(now)}/output.aac';
    return moveFile(
        File('${(await getApplicationDocumentsDirectory()).path}/output.aac'),
        dest);
  }

  Future<void> deleteRecordMedia(ModelRecord? record) async {
    if (record == null || record.previewTrack == null) {
      return;
    }
    final exist = File(record.previewTrack!.path).existsSync();
    if (exist) {
      File(record.previewTrack!.path).delete();
      final parentDirPath = record.previewTrack!.path.split('/')..removeLast();
      Directory(parentDirPath.join('/')).delete(recursive: true);
    }
    if (record.tracks == null) {
      return;
    }
    for (final track in record.tracks!) {
      final exist = File(track.path).existsSync();
      if (exist) {
        File(track.path).delete();
      }
    }
  }

  Future<void> deleteTrackMedia(ModelTrack? track, {bool temp = false}) async {
    if (track == null) {
      return;
    }
    if (temp) {
      final sound = FlutterSoundRecorder();
      sound.openAudioSession();
      track.path = (await sound.getRecordURL(path: track.path))!;
    }
    final exist = File(track.path).existsSync();
    if (exist) {
      File(track.path).delete();
    }
  }
}
