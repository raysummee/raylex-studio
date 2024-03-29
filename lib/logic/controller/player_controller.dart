import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

class PlayerController {
  PlayerController() {
    audioPlayer = FlutterSoundPlayer();
  }

  late FlutterSoundPlayer audioPlayer;
  StreamSubscription<PlaybackDisposition>? onPlayerStateChange;
  StreamController<PlayerState> playbackStateController =
      StreamController.broadcast();
  Future<void> play(String fullpath, void Function() whenFinished) async {
    debugPrint(fullpath);
    if (!audioPlayer.isOpen()) {
      await audioPlayer.openAudioSession();
    }
    await audioPlayer
        .setSubscriptionDuration(const Duration(milliseconds: 100));
    await audioPlayer.startPlayer(
        fromURI: fullpath.replaceFirst('/', ''), whenFinished: whenFinished);
    playbackStateController.add(PlayerState.isPlaying);
  }

  Future<void> resume() async {
    await audioPlayer.resumePlayer();
    playbackStateController.add(PlayerState.isPlaying);
  }

  Future<void> pause() async {
    await audioPlayer.pausePlayer();
    playbackStateController.add(PlayerState.isPaused);
  }

  Future<void> stop() async {
    await audioPlayer.stopPlayer();
    playbackStateController.add(PlayerState.isStopped);
  }

  Future<void> onChange(Function(Duration) durationHandler,
      Function(Duration) positionHandler) async {
    if (!audioPlayer.isOpen()) {
      await audioPlayer.openAudioSession();
    }
    onPlayerStateChange = audioPlayer.dispositionStream()!.listen((event) {
      durationHandler(event.duration);
      positionHandler(event.position);
    });
  }

  Future<void> setSeek(Duration seek) async {
    await audioPlayer.seekToPlayer(seek);
  }

  Future<void> dispose({bool soft = false}) async {
    if (audioPlayer.isPlaying) {
      playbackStateController.add(PlayerState.isStopped);
      await audioPlayer.stopPlayer();
    }
    if (soft) {
      return;
    }
    await playbackStateController.close();
    await onPlayerStateChange?.cancel();
  }
}
