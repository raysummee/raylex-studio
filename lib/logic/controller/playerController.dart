import 'package:audioplayers/audioplayers.dart';

class PlayerController{
  late AudioPlayer audioPlayer;
  PlayerController(){
    AudioPlayer.logEnabled = false;
    audioPlayer = AudioPlayer();
  }
  Future<void> play(String fullpath) async{
    print(fullpath);
    await audioPlayer.play(fullpath, isLocal: true);
  } 
  Future<void> resume() async{
    await audioPlayer.resume();
  }

  Future<void> stop() async{
    await audioPlayer.stop();
  }

  Future<void> setNewUrl(String fullpath) async{
    await audioPlayer.setUrl(fullpath);
  }

  void onDurationChange(Function (Duration) handler){
    audioPlayer.onDurationChanged.listen((event) {
      handler(event);
    });
  }

  void onPositionChange(Function(Duration) handler){
    audioPlayer.onAudioPositionChanged.listen((event) {
      handler(event);
    });
  }

  void onComplete(Function handler){
    audioPlayer.onPlayerStateChanged.listen((event) {
      if(event==PlayerState.COMPLETED||event==PlayerState.STOPPED)
      handler();
    });
  }

  Future<int> setSeek(Duration seek) async{
    return await audioPlayer.seek(seek);
  }
}