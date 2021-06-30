import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SongTile extends StatelessWidget {
  final String recordLabel;
  final DateTime dateTime;
  final VoidCallback onTap;
  const SongTile({ 
    required this.recordLabel, 
    required this.dateTime, 
    required this.onTap,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Material(
          color: Color.fromARGB(255, 253, 253, 253),
          child: CupertinoButton(
            onPressed: onTap,
            padding: EdgeInsets.zero,
            // splashFactory: NoSplash.splashFactory,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recordLabel,
                    style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 0,
                      color: Colors.black,
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
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 112, 112, 112)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}