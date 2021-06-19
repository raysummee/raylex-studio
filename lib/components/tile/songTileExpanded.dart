import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:intl/intl.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderThumbShape.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderTrackShape.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';

class SongTileExpanded extends StatefulWidget {
  final String recordLabel;
  final DateTime dateTime;
  final ModelTrack track;
  const SongTileExpanded({ 
    required this.recordLabel, 
    required this.dateTime, 
    required this.track,
    Key? key 
  }) : super(key: key);

  @override
  _SongTileExpandedState createState() => _SongTileExpandedState();
}

class _SongTileExpandedState extends State<SongTileExpanded> with TickerProviderStateMixin{
  double seekValue = 0.0;
  late FlutterSoundPlayer player;
  late AnimationController animationController;
  @override
  void initState() {
    player = FlutterSoundPlayer();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: EdgeInsets.only(bottom: 2,),
        padding: EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 253, 253, 253),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                widget.recordLabel,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                DateFormat('dd-MMM-yyyy').format(widget.dateTime),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 112, 112, 112)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Color.fromARGB(255, 112, 112, 112),
                  thumbColor: Colors.white,
                  inactiveTrackColor: Color.fromARGB(255, 237, 237, 237),
                  thumbShape: CustomSliderThumbShape(
                    disabledThumbRadius: 10
                  ),
                  trackShape: CustomSliderTrackShape()
                ),
                child: Slider(
                  value: seekValue, 
                  max: widget.track.milis,
                  onChanged: (val){
                    setState(() {
                      seekValue = val;
                    });
                  }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  CupertinoButton(
                    onPressed: (){
                      if(animationController.value==0){
                        animationController.forward();
                        player.openAudioSession();
                        player.startPlayer(fromURI: widget.track.path);
                      }else{
                        animationController.reverse();
                        player.pausePlayer();
                        player.closeAudioSession();
                      }
                    }, 
                    child: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: animationController,
                      size: 50,
                      color: Colors.black,
                    )
                  ),
                  CupertinoButton(
                    onPressed: (){}, 
                    child: Icon(
                      Icons.delete,
                      size: 40,
                      color: Colors.black
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

