import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raylex_studio/screens/recordPanel/components/recordPanelSeekbar.dart';

class RecordPanelAppbar extends StatelessWidget {
  final String title;
  const RecordPanelAppbar({ Key? key, required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          width: double.infinity,
          child: UnconstrainedBox(
            child: Container(
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
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: 60+MediaQuery.of(context).viewPadding.top,
              padding: EdgeInsets.fromLTRB(28, MediaQuery.of(context).viewPadding.top, 28, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
        RecordPanelSeekbar()
      ],
    );
  }
}