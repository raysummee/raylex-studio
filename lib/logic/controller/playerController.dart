import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';

class PlayerController{
  late FlutterSoundPlayer audioPlayer;
  StreamSubscription<PlaybackDisposition>? onPlayerStateChange;
  PlayerController(){
    audioPlayer = FlutterSoundPlayer();
  }
  Future<void> play(String fullpath, void Function() whenFinished) async{
    print(fullpath);
    await audioPlayer.setSubscriptionDuration(Duration(milliseconds: 100));
    await audioPlayer.startPlayer(fromURI: "${fullpath.replaceFirst("/", "")}", whenFinished: whenFinished);
  } 
  Future<void> resume() async{
    await audioPlayer.resumePlayer();
  }

  Future<void> pause() async{
    await audioPlayer.pausePlayer();
  }

  Future<void> stop() async{
    await audioPlayer.stopPlayer();
  }

  void onChange(Function (Duration) durationHandler, Function (Duration) positionHandler) async{
    await audioPlayer.openAudioSession();
    onPlayerStateChange = audioPlayer.dispositionStream()!.listen((event) {
      durationHandler(event.duration);
      positionHandler(event.position);
    });
  }

  Future<void> setSeek(Duration seek) async{
    await audioPlayer.seekToPlayer(seek);
  }

  void dispose() async{
    await onPlayerStateChange?.cancel();
  }

  
}