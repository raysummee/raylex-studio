import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';
import 'package:raylex_studio/logic/helpers/modelRecordHelper.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';
import 'package:raylex_studio/screens/recordPanel/components/addNewTrackButton.dart';
import 'package:raylex_studio/screens/recordPanel/components/recordPanelAppbar.dart';
import 'package:raylex_studio/screens/recordPanel/components/recordTrackTile.dart';
import 'package:video_player/video_player.dart';

class RecordPanel extends StatefulWidget {
  final ModelRecord? record;
  const RecordPanel({ Key? key, this.record }) : super(key: key);

  @override
  _RecordPanelState createState() => _RecordPanelState();
}

class _RecordPanelState extends State<RecordPanel> {
  double sliderValue = 0.5;
  late ModelRecord record;
  late var chewieController;
  final videoPlayerController = VideoPlayerController.asset('assets/images/butterfly.mp4');

  @override
  void initState() {
    if(widget.record==null){
      record = ModelRecord(
        name: "New Recording", 
        tracks: [ModelTrack(name: "Track 1", path: 11, milis: 0)], 
        exported: false, 
        onCreated: DateTime.now(), 
        onUpdated: DateTime.now()
      );
    }else{
      record = widget.record!;
    }
    videoPlayerController.initialize().then((value) => videoPlayerController.play());

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      allowFullScreen: false,
      showControls: false,
      aspectRatio: 16/9
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        child: RecordPanelAppbar(title: record.name), 
        preferredSize: Size.fromHeight(85)
      ),
      body: Stack(
        children: [ 
          Transform.translate(
            offset: Offset(0, 105),
            child: Container(
              height: MediaQuery.of(context).size.height-kToolbarHeight,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16/9,
                    child: Chewie(controller: chewieController)
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: record.tracks==null?0:record.tracks!.length,
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: RecordTrackTile(
                            trackName: "Track 1",
                            type: RecordTileType.Record,
                          ),
                        );
                      }
                    ),
                  ),
                  Container(
                    color: Theme.of(context).canvasColor,
                    height: 60,
                  )
                ],
              ),
            ),
          ),
          AddNewTrackButton(),
        ],
      ),
    );
  }
}