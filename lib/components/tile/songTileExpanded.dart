import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderThumbShape.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderTrackShape.dart';
import 'package:raylex_studio/logic/controller/playerController.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';

class SongTileExpanded extends StatefulWidget {
  final String recordLabel;
  final DateTime dateTime;
  final ModelTrack track;
  final PlayerController playerController;
  const SongTileExpanded({ 
    required this.recordLabel, 
    required this.dateTime, 
    required this.track,
    required this.playerController,
    Key? key 
  }) : super(key: key);

  @override
  _SongTileExpandedState createState() => _SongTileExpandedState();
}

class _SongTileExpandedState extends State<SongTileExpanded> with TickerProviderStateMixin{
  late AnimationController animationController;
  double seekLower = 0;
  double seekHigher = 0;
  double seekCurrent = 0;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1
    );
    widget.playerController.onDurationChange((duration){
      if(seekHigher!=duration.inMilliseconds){
        setState(() {
          seekHigher = duration.inMilliseconds.toDouble();
        });
      }
    });
    widget.playerController.onPositionChange((duration){
      setState(() {
        seekCurrent = duration.inMilliseconds.toDouble();
      });
    });
    widget.playerController.onComplete((){
      print("debug");
      animationController.reverse();
    });
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
                  value: seekCurrent, 
                  max: seekHigher,
                  onChanged: (val){
                    // setState(() {
                    //   seekValue = val;
                    // });
                  }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  CupertinoButton(
                    onPressed: () async{
                      if(animationController.value==0){
                        animationController.forward();
                        widget.playerController.play(widget.track.path);
                      }else{
                        animationController.reverse();
                        widget.playerController.stop();
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

