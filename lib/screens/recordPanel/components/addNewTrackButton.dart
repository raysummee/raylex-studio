import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewTrackButton extends StatelessWidget {
  const AddNewTrackButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom+8, 
          right: 28
        ),
        child: CupertinoButton(
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
      ),
    );
  }
}