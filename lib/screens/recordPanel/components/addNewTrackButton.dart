import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewTrackButton extends StatelessWidget {
  const AddNewTrackButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.02),
              offset: Offset(0, -3)
            )
          ]
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom+8, 
          top: 8,
          right: 28,
          left: 28
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              child: Icon(
                Icons.play_arrow,  
                size: 30,                     
                color: Color.fromARGB(255, 112, 112, 112),
              ), 
              onPressed: (){}
            ),
            CupertinoButton(
              onPressed: (){},
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add New Track",
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 112, 112),
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(
                    Icons.add_circle,
                    color: Color.fromARGB(255, 112, 112, 112),
                    size: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}