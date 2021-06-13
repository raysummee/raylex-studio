import 'package:flutter/material.dart';
import 'package:raylex_studio/screens/home/components/recordButton.dart';

class RecordBottomsheet extends StatelessWidget {
  const RecordBottomsheet({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0,-3),
            color: Colors.black.withOpacity(0.02)
          )
        ]
      ),
      height: 200,
      width: double.infinity,
      child: RecordButton()
    );
  }
}