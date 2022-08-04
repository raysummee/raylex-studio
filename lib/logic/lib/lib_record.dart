import 'package:flutter/foundation.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class LibRecord {
  FlutterSoundPlayer? _mPlayer;
  FlutterSoundRecorder? _mRecorder;
  bool _mPlayerIsInited = false;

  Future<void> init() async {
    _mPlayer = FlutterSoundPlayer();
    _mRecorder = FlutterSoundRecorder();
    await _mPlayer!.openAudioSession();
    _mPlayerIsInited = true;
    await openTheRecorder();
  }

  Future<String?> url(String mPath) async {
    return _mRecorder!.getRecordURL(path: mPath);
  }

  void dispose() {
    _mPlayer!.closeAudioSession();
    _mRecorder!.closeAudioSession();
    _mPlayer = null;
    _mRecorder = null;
  }

  Future<void> recordStart(String path) async {
    if (path.contains('/')) {
      return;
    }
    await _mRecorder!.closeAudioSession();
    await _mRecorder!.openAudioSession();
    await _mRecorder!.startRecorder(
      toFile: path,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    );
    debugPrint('start record $path');
  }

  Future<void> play(String path, void Function() whenFinished) async {
    debugPrint('playing start $path');
    if (!_mPlayerIsInited ||
        // !_mplaybackReady ||
        !_mRecorder!.isStopped ||
        !_mPlayer!.isStopped) {
      return;
    }
    debugPrint('playing');

    await _mPlayer!.startPlayer(
        fromURI: path,
        //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: whenFinished);
  }

  Future<void> stopPlayer() async {
    await _mPlayer!.stopPlayer();
    debugPrint('stop playing');
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    debugPrint('stop record');
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        debugPrint('Microphone permission not granted');
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openAudioSession();
  }

  Stream<RecordingDisposition>? recorderProgressListen() {
    if (_mRecorder != null) {
      return _mRecorder!.onProgress;
    }
    return null;
  }
}
