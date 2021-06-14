import 'package:flutter/material.dart';
import 'package:raylex_studio/screens/recordPanel/components/recordPanelAppbar.dart';

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
              ],
            ),
          ),
          RecordPanelAppbar(title: "Your Song")
        ],
      ),
    );
  }
}