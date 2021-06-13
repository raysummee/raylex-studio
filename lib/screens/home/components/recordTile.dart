import 'package:flutter/material.dart';

class RecordTile extends StatelessWidget {
  const RecordTile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 95,
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 253, 253, 253),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Recording 1",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "13-May-2021",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 112, 112, 112)
              ),
            ),
          ],
        ),
      ),
    );
  }
}