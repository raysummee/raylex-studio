import 'package:flutter/material.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderOverlayShape.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderThumbShape.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderTrackShape.dart';
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
      body: Column(
        children: [
          RecordPanelAppbar(title: "Your Song"),
           SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Color.fromARGB(255, 255, 80, 80),
              thumbColor: Colors.white,
              inactiveTrackColor: Color.fromARGB(255, 237, 237, 237),
              overlayColor: Color.fromARGB(255, 255, 80, 80),
              overlayShape: CustomSliderOverlayShape(),
              thumbShape: CustomSliderThumbShape(
                disabledThumbRadius: 0,
                showThumb: false
              ),
              disabledThumbColor: Colors.black,
              

              trackShape: CustomSliderTrackShape(dense: true)
            ),
            child: Slider(
              value: sliderValue, 

              onChanged: (val){
                setState(() {
                  sliderValue = val;
                });
              }
            ),
          ),
        ],
      ),
    );
  }
}