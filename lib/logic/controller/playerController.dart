import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class PlayerController{
  late AudioPlayer audioPlayer;
  StreamSubscription<PlayerState>? onPlayerStateChange;
  StreamSubscription<Duration>? onPlayerPositionChange;
  StreamSubscription<Duration>? onPlayerDurationChange;
  PlayerController(){
    AudioPlayer.logEnabled = false;
    audioPlayer = AudioPlayer();
    audioPlayer.setReleaseMode(ReleaseMode.STOP);
  }
  Future<void> play(String fullpath) async{
    print(fullpath);
    await audioPlayer.play(fullpath, isLocal: true);
  } 
  Future<void> resume() async{
    await audioPlayer.resume();
  }

  Future<void> pause() async{
    await audioPlayer.pause();
  }

  Future<void> stop() async{
    await audioPlayer.stop();
  }

  Future<void> setNewUrl(String fullpath) async{
    await audioPlayer.setUrl(fullpath, isLocal: true);
  }

  void onDurationChange(Function (Duration) handler){
    onPlayerDurationChange = audioPlayer.onDurationChanged.listen((event) {
      print("duration changed: ${event.inSeconds}");
      handler(event);
    });
  }

  void onPositionChange(Function(Duration) handler){
    onPlayerPositionChange = audioPlayer.onAudioPositionChanged.listen((event) {
      handler(event);
    });
  }

  void onComplete(Function handler){
    onPlayerStateChange = audioPlayer.onPlayerStateChanged.listen((event) {
      if(event==PlayerState.COMPLETED||event==PlayerState.STOPPED)
      handler();
    });
  }

  Future<int> setSeek(Duration seek) async{
    return await audioPlayer.seek(seek);
  }

  void dispose() async{
    await onPlayerStateChange?.cancel();
    await onPlayerPositionChange?.cancel();
    await onPlayerDurationChange?.cancel();
    await audioPlayer.dispose();
  }

  
}