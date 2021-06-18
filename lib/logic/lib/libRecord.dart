import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class LibRecord{
  static FlutterSoundPlayer? _mPlayer;
  static FlutterSoundRecorder? _mRecorder;
  static bool _mPlayerIsInited = false;
  static bool _mRecorderIsInited = false;
  static bool _mplaybackReady = false;
  static String _mPath = 'track_1.aac';

  Future<void> init() async{
    _mPlayer = FlutterSoundPlayer();
    _mRecorder = FlutterSoundRecorder();
    await _mPlayer!.openAudioSession();
    _mPlayerIsInited = true;
    await openTheRecorder();
  }

  void dispose(){
    _mPlayer!.closeAudioSession();
    _mRecorder!.closeAudioSession();
    _mPlayer = null;
    _mRecorder = null;
  }

  Future<void> recordStart() async{
    await _mRecorder!.startRecorder(
      toFile: _mPath,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    );
  }


  Future<void> play(void Function() whenFinished) async{
    if(
      _mPlayerIsInited &&
      _mplaybackReady &&
      _mRecorder!.isStopped &&
      _mPlayer!.isStopped
    ){
      return;
    }

    await _mPlayer!.startPlayer(
      fromURI: _mPath,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
      whenFinished: whenFinished
    );
  }

  Future<void> stopPlayer() async{
    await _mPlayer!.stopPlayer();
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    _mplaybackReady = true;
  }

  // String? changeTrack(String trackName) {
  //   if(!_mRecorder!.isRecording){
  //     _mPath = trackName.trim().replaceAll(" ", "_").toLowerCase();
  //     return _mPath;
  //   }
  //   return null;
  // }

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
}