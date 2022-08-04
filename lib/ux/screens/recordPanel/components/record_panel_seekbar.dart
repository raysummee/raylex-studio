import 'package:flutter/material.dart';
import 'package:raylex_studio/ux/canvas/SliderShapes/custom_slider_overlay_shape.dart';
import 'package:raylex_studio/ux/canvas/SliderShapes/custom_slider_thumb_shape.dart';
import 'package:raylex_studio/ux/canvas/SliderShapes/custom_slider_track_shape.dart';

class RecordPanelSeekbar extends StatefulWidget {
  const RecordPanelSeekbar({Key? key, required this.sliderValue})
      : super(key: key);
  final double sliderValue;

  @override
  State<RecordPanelSeekbar> createState() => _RecordPanelSeekbarState();
}

class _RecordPanelSeekbarState extends State<RecordPanelSeekbar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SliderTheme(
          data: SliderThemeData(
              activeTrackColor: const Color.fromARGB(255, 255, 80, 80),
              thumbColor: Colors.white,
              inactiveTrackColor: const Color.fromARGB(255, 237, 237, 237),
              overlayColor: const Color.fromARGB(255, 255, 80, 80),
              overlayShape: const CustomSliderOverlayShape(),
              thumbShape: const CustomSliderThumbShape(
                  disabledThumbRadius: 0, showThumb: false),
              disabledThumbColor: Colors.black,
              trackShape: CustomSliderTrackShape()),
          child: Slider(
              value: widget.sliderValue,
              onChanged: (val) {
                // setState(() {
                //   sliderValue = val;
                // });
              }),
        ),
      ),
    );
  }
}
