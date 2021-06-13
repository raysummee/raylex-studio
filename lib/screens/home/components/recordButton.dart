import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: CupertinoButton(
        onPressed: (){},
        child: Container(
          height: 69,
          width: 69,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255,255, 80, 80),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                offset: Offset(0,3),
                color: Colors.black.withOpacity(0.16)
              )
            ]
          ),
        ),
      ),
    );
  }
}