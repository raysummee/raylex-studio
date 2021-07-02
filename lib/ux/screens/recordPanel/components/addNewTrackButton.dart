import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';

class AddNewTrackButton extends StatefulWidget {
  final bool Function (bool) onPlayClick;
  final VoidCallback addNewTrack;
  final ModelRecord modelRecord;
  const AddNewTrackButton({ Key? key, required this.onPlayClick, required this.addNewTrack, required this.modelRecord }) : super(key: key);

  @override
  _AddNewTrackButtonState createState() => _AddNewTrackButtonState();
}

class _AddNewTrackButtonState extends State<AddNewTrackButton> with TickerProviderStateMixin{
  late AnimationController animation;
  void onPlay(){
    if(mounted)
    animation.forward();
  }
  void onStop(){
    if(mounted)
    animation.reverse();
  }
  @override
  void initState() {
    animation = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: Duration(milliseconds: 300)
    );
    widget.modelRecord.onPlayStopDispatch = onStop;
    widget.modelRecord.onPlayingDispatch = onPlay;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.02),
              offset: Offset(0, -3)
            )
          ]
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom+8, 
          top: 8,
          right: 28,
          left: 28
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: animation,
                size: 30,                     
                color: Color.fromARGB(255, 112, 112, 112),
              ), 
              onPressed: (){
                if(animation.value==0){
                 if(widget.onPlayClick(true))
                  animation.forward();
                }else if(animation.value==1){
                  if(widget.onPlayClick(false))
                  animation.reverse();
                }
              }
            ),
            CupertinoButton(
              onPressed: widget.addNewTrack,
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add New Track",
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 112, 112),
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(
                    Icons.add_circle,
                    color: Color.fromARGB(255, 112, 112, 112),
                    size: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}