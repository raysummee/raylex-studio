import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';

class RecordTrackTile extends StatefulWidget {
  final ModelTrack track;
  const RecordTrackTile({ 
    Key? key, 
    required this.track
  }) : super(key: key);

  @override
  _RecordTrackTileState createState() => _RecordTrackTileState();
}

class _RecordTrackTileState extends State<RecordTrackTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        setState(() {
          widget.track.recordType = widget.track.recordType==RecordTileType.Display?
            RecordTileType.None:
            RecordTileType.Display;
        });
      },
      onTap: (){
        setState(() {
            widget.track.recordType = widget.track.recordType==RecordTileType.Record?
              RecordTileType.None:
              RecordTileType.Record;
        });
      },
      contentPadding: EdgeInsets.fromLTRB(28, 16, 28, 16),
      title: Text(
        widget.track.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold
        ),
      ),
      tileColor: Colors.white,
      trailing: ((){
        switch (widget.track.recordType) {
          case RecordTileType.None:
            return null;
          case RecordTileType.Display:
            return Image.asset("assets/icon/being display.png", height: 20,);
          case RecordTileType.Record:
            return Image.asset("assets/icon/being record.png", height: 20,);
        }
      }()) ,
    );
  }
}