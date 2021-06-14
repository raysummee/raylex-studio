import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderThumbShape.dart';
import 'package:raylex_studio/components/SliderShapes/customSliderTrackShape.dart';

class SongTileExpanded extends StatelessWidget {
  final String recordLabel;
  final DateTime dateTime;
  const SongTileExpanded({ 
    required this.recordLabel, 
    required this.dateTime, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        margin: EdgeInsets.only(bottom: 2,),
        padding: EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 253, 253, 253),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                recordLabel,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                DateFormat('dd-MMM-yyyy').format(dateTime),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 112, 112, 112)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Color.fromARGB(255, 112, 112, 112),
                  thumbColor: Colors.white,
                  inactiveTrackColor: Color.fromARGB(255, 237, 237, 237),
                  thumbShape: CustomSliderThumbShape(
                    disabledThumbRadius: 10
                  ),
                  trackShape: CustomSliderTrackShape()
                ),
                child: Slider(
                  value: 0.4, 
                  onChanged: (val){}
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  CupertinoButton(
                    onPressed: (){}, 
                    child: Icon(
                      Icons.play_arrow,
                      size: 50,
                      color: Colors.black,
                    )
                  ),
                  CupertinoButton(
                    onPressed: (){}, 
                    child: Icon(
                      Icons.delete,
                      size: 40,
                      color: Colors.black
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

