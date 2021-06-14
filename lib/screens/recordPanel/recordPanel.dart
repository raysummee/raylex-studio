import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/enums/RecordTileType.dart';
import 'package:raylex_studio/screens/recordPanel/components/addNewTrackButton.dart';
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
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        child: RecordPanelAppbar(title: "Your Song"), 
        preferredSize: Size.fromHeight(85)
      ),
      body: Stack(
        children: [ 
          Transform.translate(
            offset: Offset(0, kToolbarHeight),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/cover.jpg",
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height-kToolbarHeight-kBottomNavigationBarHeight)*0.4,
                  fit: BoxFit.cover,
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
          AddNewTrackButton(),
        ],
      ),
    );
  }
}