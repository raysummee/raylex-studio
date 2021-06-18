import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';
import 'package:raylex_studio/logic/models/modelTrack.dart';

class RecordTrackTile extends StatelessWidget {
  final ModelTrack track;
  const RecordTrackTile({ 
    Key? key, 
    required this.track
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(28, 16, 28, 16),
      title: Text(
        track.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold
        ),
      ),
      tileColor: Colors.white,
      trailing: ((){
        switch (track.recordType) {
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