import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordPanelAppbar extends StatelessWidget {
  final String title;
  const RecordPanelAppbar({ Key? key, required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0,3),
            color: Colors.black.withOpacity(0.02)
          )
        ]
      ),
      width: double.infinity,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500
                ),
              ),
              ElevatedButton(
                child: Text(
                  "End", 
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                  ),
                ), 
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(78, 41),
                  primary: Color.fromARGB(255, 255, 80, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)
                  ),
                ),
                onPressed: (){}
              )
            ],
          ),
        ),
      ),
    );
  }
}