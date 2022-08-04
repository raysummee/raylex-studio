import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:raylex_studio/logic/controller/player_controller.dart';
import 'package:raylex_studio/logic/models/model_track.dart';
import 'package:raylex_studio/ux/canvas/SliderShapes/custom_slider_thumb_shape.dart';
import 'package:raylex_studio/ux/canvas/SliderShapes/custom_slider_track_shape.dart';

class SongTileExpanded extends StatefulWidget {
  const SongTileExpanded(
      {required this.recordLabel,
      required this.dateTime,
      required this.track,
      required this.onDelete,
      required this.playerController,
      required this.active,
      Key? key})
      : super(key: key);
  final String recordLabel;
  final DateTime dateTime;
  final ModelTrack track;
  final VoidCallback onDelete;
  final PlayerController playerController;
  final bool active;

  @override
  State<SongTileExpanded> createState() => _SongTileExpandedState();
}

class _SongTileExpandedState extends State<SongTileExpanded>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  double seekLower = 0;
  double seekHigher = 0;
  double seekCurrent = 0;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  void changePlayerProps() {
    widget.playerController.playbackStateController.stream.listen((state) {
      if (!widget.active) {
        return;
      }
      if (!mounted) {
        return;
      }
      if (state == PlayerState.isPlaying && animationController.value != 1) {
        animationController.forward();
      } else if ((state == PlayerState.isPaused ||
              state == PlayerState.isStopped) &&
          animationController.value != 0) {
        animationController.reverse();
        if (state == PlayerState.isStopped) {
          setState(() {
            seekCurrent = seekLower;
          });
        }
      }
    });
    widget.playerController.onChange(
      (duration) {
        if (!widget.active) {
          return;
        }
        if (!mounted) {
          return;
        }
        debugPrint('duration came');
        if (seekHigher != duration.inMilliseconds) {
          setState(() {
            seekHigher = duration.inMilliseconds.toDouble();
          });
        }
      },
      (duration) {
        if (!widget.active) {
          return;
        }
        if (!mounted) {
          return;
        }
        setState(() {
          seekCurrent = duration.inMilliseconds.toDouble();
        });
      },
    );
  }

  @override
  void didChangeDependencies() {
    if (seekHigher == 0) {
      changePlayerProps();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.playerController.dispose(soft: true);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 2,
        ),
        padding: const EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 253, 253, 253),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                widget.recordLabel,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                DateFormat('dd-MMM-yyyy').format(widget.dateTime),
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 112, 112, 112)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SliderTheme(
                data: SliderThemeData(
                    activeTrackColor: const Color.fromARGB(255, 112, 112, 112),
                    thumbColor: Colors.white,
                    inactiveTrackColor:
                        const Color.fromARGB(255, 237, 237, 237),
                    thumbShape:
                        const CustomSliderThumbShape(disabledThumbRadius: 10),
                    trackShape: CustomSliderTrackShape()),
                child: Slider(
                    value: seekCurrent,
                    max: seekHigher,
                    onChanged: (val) {
                      widget.playerController
                          .setSeek(Duration(milliseconds: val.toInt()));
                      setState(() {
                        seekCurrent = val;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  CupertinoButton(
                      onPressed: () async {
                        if (animationController.value == 0) {
                          debugPrint(
                              (seekCurrent != 0 && seekCurrent < seekHigher)
                                  .toString());
                          if (seekCurrent != 0 && seekCurrent < seekHigher) {
                            widget.playerController.resume();
                          }
                          {
                            widget.playerController.play(widget.track.path,
                                () => animationController.reverse());
                          }
                        } else {
                          widget.playerController.pause();
                        }
                      },
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: animationController,
                        size: 50,
                        color: Colors.black,
                      )),
                  CupertinoButton(
                      onPressed: widget.onDelete,
                      child: const Icon(Icons.delete,
                          size: 40, color: Colors.black)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
