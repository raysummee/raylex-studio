import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class LibRecord{
  static FlutterSoundPlayer? _mPlayer;
  static FlutterSoundRecorder? _mRecorder;
  static bool _mPlayerIsInited = false;
  static bool _mRecorderIsInited = false;
  static bool _mplaybackReady = false;
  static final String _mPath = 'flutter_sound_example.aac';

  static Future<void> init() async{
    _mPlayer = FlutterSoundPlayer();
    _mRecorder = FlutterSoundRecorder();
    await _mPlayer!.openAudioSession();
    _mPlayerIsInited = true;
    await openTheRecorder();
  }

  static void dispose(){
    _mPlayer!.closeAudioSession();
    _mRecorder!.closeAudioSession();
    _mPlayer = null;
    _mRecorder = null;
  }

  static Future<void> recordStart() async{
    await _mRecorder!.startRecorder(
      toFile: _mPath,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
    );
  }


  static Future<void> play(void Function() whenFinished) async{
    assert(
      _mPlayerIsInited &&
      _mplaybackReady &&
      _mRecorder!.isStopped &&
      _mPlayer!.isStopped
    );

    await _mPlayer!.startPlayer(
      fromURI: _mPath,
      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
      whenFinished: whenFinished
    );
  }

  static Future<void> stopPlayer() async{
    await _mPlayer!.stopPlayer();
  }

  static Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    _mplaybackReady = true;
  }

  static Future<void> openTheRecorder() async {
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