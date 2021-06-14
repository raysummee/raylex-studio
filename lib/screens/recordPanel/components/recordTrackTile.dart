import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';

class RecordTrackTile extends StatelessWidget {
  final String trackName;
  final RecordTileType type;
  const RecordTrackTile({ 
    Key? key, 
    required this.trackName, 
    required this.type 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(28, 16, 28, 16),
      title: Text(
        trackName,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold
        ),
      ),
      tileColor: Colors.white,
      trailing: ((){
        switch (type) {
          case RecordTileType.None:
            return null;
          case RecordTileType.Display:
            return Image.asset("assets/icon/being display.png");
          case RecordTileType.Record:
            return Image.asset("assets/icon/being record.png");
        }
      }()) ,
    );
  }
}