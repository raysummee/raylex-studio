import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';
import 'package:raylex_studio/screens/recordPanel/components/recordPanelAppbar.dart';
import 'package:raylex_studio/screens/recordPanel/components/recordTrackTile.dart';

class RecordPanel extends StatefulWidget {
  const RecordPanel({ Key? key }) : super(key: key);

  @override
  _RecordPanelState createState() => _RecordPanelState();
}

class _RecordPanelState extends State<RecordPanel> {
  double sliderValue = 0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ 
          Transform.translate(
            offset: Offset(0, 80+kToolbarHeight),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/cover.jpg",
                  height: 300,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(height: 16,),
                RecordTrackTile(
                  trackName: "Track 1",
                  type: RecordTileType.Record,
                ),
                SizedBox(height: 8,),
                RecordTrackTile(
                  trackName: "Karoke Track",
                  type: RecordTileType.Display,
                ),
              ],
            ),
          ),
          RecordPanelAppbar(title: "Your Song")
        ],
      ),
    );
  }
}