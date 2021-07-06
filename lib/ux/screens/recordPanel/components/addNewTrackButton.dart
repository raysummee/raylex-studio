import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/controller/recordController.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';
import 'package:raylex_studio/ux/screens/recordPanel/components/addTrackOverlay.dart';

class AddNewTrackButton extends StatefulWidget {
  final bool Function (bool) onPlayClick;
  final void Function (ModelTrack) importTrack;
  final VoidCallback addNewTrack;
  final ModelRecord modelRecord;
  const AddNewTrackButton({ 
    Key? key, 
    required this.onPlayClick, 
    required this.addNewTrack, 
    required this.modelRecord,
    required this.importTrack
  }) : super(key: key);

  @override
  _AddNewTrackButtonState createState() => _AddNewTrackButtonState();
}

class _AddNewTrackButtonState extends State<AddNewTrackButton> with TickerProviderStateMixin{
  late AnimationController animationPlayer;
  late AnimationController animationOverlay;
  OverlayEntry? _overlayEntry;
  bool isNewTrackOvelayOpen = false;

  final LayerLink _layerLink = LayerLink();

  void onPlay(){
    if(mounted)
    animationPlayer.forward();
  }
  void onStop(){
    if(mounted)
    animationPlayer.reverse();
  }
  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }
  @override
  void initState() {
    animationPlayer = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: Duration(milliseconds: 300)
    );
    animationOverlay = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: Duration(milliseconds: 150)
    );
    widget.modelRecord.onPlayStopDispatch = onStop;
    widget.modelRecord.onPlayingDispatch = onPlay;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
              progress: animationPlayer,
              size: 30,
              color: Color.fromARGB(255, 112, 112, 112),
            ), 
            onPressed: (){
              if(animationPlayer.value==0){
               if(widget.onPlayClick(true))
                animationPlayer.forward();
              }else if(animationPlayer.value==1){
                if(widget.onPlayClick(false))
                animationPlayer.reverse();
              }
            }
          ),
          CompositedTransformTarget(
            link: _layerLink,
            child: CupertinoButton(
              onPressed: (){
                if(!isNewTrackOvelayOpen){
                  isNewTrackOvelayOpen = true;
                  _overlayEntry?.remove();
                  _overlayEntry = AddTrackOverlay.createOverlayEntry(
                    context: context,
                    layerLink: _layerLink,
                    animation: animationOverlay,
                    onTopTap: () async{
                      isNewTrackOvelayOpen = false;
                      ModelTrack? modelTrack = await RecordController().importTrack();
                      if(modelTrack == null) return;
                      widget.importTrack(modelTrack);
                      animationOverlay.reverse().then((value) { 
                        _overlayEntry!.remove();
                        _overlayEntry = null;
                      });
                    },
                    onBottomTap: (){
                      isNewTrackOvelayOpen = false;
                      widget.addNewTrack();
                      animationOverlay.reverse().then((value) { 
                        _overlayEntry!.remove();
                        _overlayEntry = null;
                      });
                    }
                  );
                  Overlay.of(context)!.insert(_overlayEntry!);
                  animationOverlay.forward();
                }else{
                  isNewTrackOvelayOpen = false;
                  animationOverlay.reverse().then((value) { 
                    _overlayEntry!.remove();
                    _overlayEntry = null;
                  });
                }
              },
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
          ),
        ],
      ),
    );
  }
}