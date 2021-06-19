import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';
import 'package:raylex_studio/logic/helpers/modelRecordHelper.dart';
import 'package:raylex_studio/logic/lib/libRecord.dart';
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
  double sliderValue = 0.0;
  late ModelRecord record;
  late ChewieController chewieController;
  final videoPlayerController = VideoPlayerController.asset('assets/images/butterfly.mp4');

  int endedTracks = 0;
  void checkAllTrackEnded(){
    print("deub");
    if(record.tracks!.any((element) => element.recordType==RecordTileType.Record)){
      return;
    }
    endedTracks++;
    if(endedTracks>=record.tracks!.length){
      record.onPlayStopDispatch!();
      endedTracks = 0;
    }
  }

  void che(double val){
    print(val.toString());
    setState(() {
      sliderValue = val;
    });
  }

  @override
  void dispose() {
    // chewieController.dispose();
    videoPlayerController.dispose();
    record.tracks!.forEach((track) {
      track.record!.dispose();
    });
    super.dispose();
  }

  @override
  void initState() {
    if(widget.record==null){
      record = ModelRecord(
        name: "New Recording", 
        tracks: [ModelTrack(name: "Track 1", path: "track_1", milis: 0, recordType: RecordTileType.Record)], 
        exported: false, 
        onCreated: DateTime.now(), 
        onUpdated: DateTime.now()
      );
    }else{
      record = widget.record!;
    }
    LibRecord libRecord = new LibRecord();
    libRecord.init("Track 1");
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
  Future<File> moveFile(File sourceFile, String newPath) async {
    final newFile = await sourceFile.copy(newPath);
    return newFile;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        child: RecordPanelAppbar(onEnd: () async{
          var basNameWithExtension = record.tracks![0].path;
          var source = File((await record.tracks![0].record!.url())!);
          var dest = (await getApplicationDocumentsDirectory()).path + "/" + basNameWithExtension;
          var file =  await moveFile(source,dest);
          record.tracks![0].path = file.path;
          await ModelRecordHelper().add(name: "New", previewTrack: record.tracks![0], tracks: record.tracks);
          Navigator.of(context).pop();
        },title: record.name, sliderValue: sliderValue,), 
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
                  // AspectRatio(
                  //   aspectRatio: 16/9,
                  //   child: Chewie(controller: chewieController)
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: record.tracks==null?0:record.tracks!.length,
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: RecordTrackTile(
                            track: record.tracks![index]
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
          AddNewTrackButton(
            onPlayClick: (play){
              if(record.tracks!.where((track) => track.recordType==RecordTileType.Record).length>1){
                print("one file can be recorded for now");
                return false;
              }
              record.tracks!.forEach((track) {
                print("tile type: ${track.recordType.toString()}");
                if(track.recordType==RecordTileType.Record){
                  play? track.record!.recordStart(): track.record!.stopRecorder();
                }else{
                  play? track.record!.play(() {checkAllTrackEnded();}) : track.record!.stopPlayer();
                }
              });
              return true;
            },
            addNewTrack: () async{
              print("Adding");
              var track = ModelTrack(name: "New Track ${record.tracks!.length+1}", path: "new_track_${record.tracks!.length+1}", milis: 0);
              track.record = LibRecord();
              print("initing");
              await track.record!.init(track.name);
              print("added, state changing");
              setState(() {
                record.tracks!.add(track);
              });
            },
            modelRecord: record,
          ),
        ],
      ),
    );
  }
}