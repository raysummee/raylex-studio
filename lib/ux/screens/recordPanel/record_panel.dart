import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../logic/controller/record_controller.dart';
import '../../../logic/enums/record_tile_type.dart';
import 'package:raylex_studio/logic/lib/lib_record.dart';
import '../../../logic/models/model_record.dart';
import '../../../logic/models/model_track.dart';
import 'components/add_new_track_button.dart';
import 'components/cancel_record_dialog.dart';
import 'components/record_panel_appbar.dart';
import 'components/record_track_tile.dart';

class RecordPanel extends StatefulWidget {
  const RecordPanel({Key? key, this.record}) : super(key: key);
  final ModelRecord? record;

  @override
  State<RecordPanel> createState() => _RecordPanelState();
}

class _RecordPanelState extends State<RecordPanel> {
  double sliderValue = 0.0;
  bool didEdit = false;
  late ModelRecord record;
  late ChewieController chewieController;
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset('assets/images/butterfly.mp4');

  void che(double val) {
    debugPrint(val.toString());
    setState(() {
      sliderValue = val;
    });
  }

  @override
  void dispose() {
    // chewieController.dispose();
    videoPlayerController.dispose();
    for (final ModelTrack track in record.tracks!) {
      if (!didEdit) {
        RecordController().deleteTrackMedia(track, temp: true);
      }
      track.record!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    if (widget.record == null) {
      record = ModelRecord(
          name: 'New Recording',
          tracks: [
            ModelTrack(
                name: 'Track 1',
                path: 'track_1.aac',
                milis: 0,
                recordType: RecordTileType.record)
          ],
          exported: false,
          onCreated: DateTime.now(),
          onUpdated: DateTime.now());
    } else {
      record = widget.record!;
    }
    final LibRecord libRecord = LibRecord();
    libRecord.init();
    record.tracks![0].record = libRecord;
    // videoPlayerController.initialize().then((value) => videoPlayerController.play());
    // videoPlayerController.addListener(() {
    //   videoPlayerController.position.then((value) => che(value!.inMilliseconds/7544));
    // });

    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: false,
    //   looping: false,
    //   allowFullScreen: false,
    //   showControls: false,
    //   aspectRatio: 16/9
    // );
    // LibRecord.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: !didEdit && Platform.isIOS
          ? null
          : () async {
              if (didEdit) {
                final bool status = await CancelRecordDialog.show(onSave: () {
                  RecordController().saveRecordingPrompt(record,
                      update: widget.record != null);
                });
                debugPrint('status: $status');
                return status;
              }
              return true;
            },
      child: Scaffold(
        body: Column(
          children: [
            RecordPanelAppbar(
              onEnd: () async {
                if (didEdit) {
                  await CancelRecordDialog.show(onSave: () {
                    RecordController().saveRecordingPrompt(record,
                        update: widget.record != null);
                  });
                } else {
                  Navigator.of(context).pop();
                }
              },
              title: record.name,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: record.tracks == null ? 0 : record.tracks!.length,
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RecordTrackTile(
                        track: record.tracks![index],
                        index: index,
                        onDelete: () {
                          final ModelTrack track = record.tracks![index];
                          setState(() {
                            record.tracks!.removeAt(index);
                          });
                          RecordController()
                              .deleteTrackMedia(track, temp: true);
                        },
                      ),
                    );
                  }),
            ),
            AddNewTrackButton(
              onPlayClick: (bool play) {
                if (!didEdit) {
                  setState(() {
                    didEdit = true;
                  });
                }
                return RecordController().onPlaybuttonClicked(play, record);
              },
              addNewTrack: () async {
                final ModelTrack track = ModelTrack(
                    name: 'New Track ${record.tracks!.length + 1}',
                    path: 'new_track_${record.tracks!.length + 1}.aac',
                    milis: 0);
                track.record = LibRecord();
                await track.record!.init();
                setState(() {
                  record.tracks!.add(track);
                });
              },
              importTrack: (ModelTrack track) async {
                track.record = LibRecord();
                await track.record!.init();
                setState(() {
                  record.tracks!.add(track);
                });
              },
              modelRecord: record,
            ),
          ],
        ),
      ),
    );
  }
}
