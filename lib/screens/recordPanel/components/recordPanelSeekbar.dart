import 'package:flutter/material.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderOverlayShape.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderThumbShape.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderTrackShape.dart';

class RecordPanelSeekbar extends StatefulWidget {
  final double sliderValue;
  const RecordPanelSeekbar({ Key? key, required this.sliderValue }) : super(key: key);

  @override
  _RecordPanelSeekbarState createState() => _RecordPanelSeekbarState();
}

class _RecordPanelSeekbarState extends State<RecordPanelSeekbar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SliderTheme(
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
              trackShape: CustomSliderTrackShape(dense: false)
            ),
            child: Slider(
              value: widget.sliderValue, 
              onChanged: (val){
                // setState(() {
                //   sliderValue = val;
                // });
              }
            ),
          ),
      ),
    );
  }
}