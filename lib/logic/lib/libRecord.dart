import 'package:flutter/foundation.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class LibRecord{
  FlutterSoundPlayer? _mPlayer;
  FlutterSoundRecorder? _mRecorder;
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  Future<void> init() async{
    _mPlayer = FlutterSoundPlayer();
    _mRecorder = FlutterSoundRecorder();
    await _mPlayer!.openAudioSession();
    _mPlayerIsInited = true;
    await openTheRecorder();
  }

  Future<String?> url(String _mPath) async{
    return await _mRecorder!.getRecordURL(path: _mPath);
  }

  void dispose(){
    _mPlayer!.closeAudioSession();
    _mRecorder!.closeAudioSession();
    _mPlayer = null;
    _mRecorder = null;
  }

  Future<void> recordStart(String path) async{
    if(path.contains("/")) return;
    await _mRecorder!.closeAudioSession();
    await _mRecorder!.openAudioSession();
    await _mRecorder!.startRecorder(
      toFile: path,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    );
    print("start record $path");
  }


  Future<void> play(path ,void Function() whenFinished) async{

    print("playing start $path");
    if(
      !_mPlayerIsInited ||
      // !_mplaybackReady ||
      !_mRecorder!.isStopped ||
      !_mPlayer!.isStopped
    ){
      return;
    }
    print("playing");

    await _mPlayer!.startPlayer(
      fromURI: path,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
      whenFinished: whenFinished
    );
  }

  Future<void> stopPlayer() async{
    await _mPlayer!.stopPlayer();
    print("stop playing");
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    _mplaybackReady = true;
    print("stop record");
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        print("Microphone permission not granted");
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openAudioSession();
    _mRecorderIsInited = true;
  }

  Stream<RecordingDisposition>? recorderProgressListen(){
    if(_mRecorder!=null){
      return _mRecorder!.onProgress;
    }
    return null;
  }
}