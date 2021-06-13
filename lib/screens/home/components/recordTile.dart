import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordTile extends StatelessWidget {
  final String recordLabel;
  final DateTime dateTime;
  const RecordTile({ 
    required this.recordLabel, 
    required this.dateTime, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 95,
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 253, 253, 253),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recordLabel,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              DateFormat('dd-MMM-yyyy').format(dateTime),
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