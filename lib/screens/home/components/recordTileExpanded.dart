import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raylex_studio/screens/home/components/customSliderThumbShape.dart';
import 'package:raylex_studio/screens/home/components/customSliderTrackShape.dart';

class RecordTileExpanded extends StatelessWidget {
  const RecordTileExpanded({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        // height: 174,
        margin: EdgeInsets.only(bottom: 2),
        // padding: EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 253, 253, 253),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "New Recording 1",
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
                "13-May-2021",
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

