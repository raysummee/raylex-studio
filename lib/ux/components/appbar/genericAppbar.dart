import 'package:flutter/material.dart';

class GenericAppbar extends StatelessWidget {
  final String title;
  const GenericAppbar({ Key? key, required this.title }) : super(key: key);

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
          height: 60+MediaQuery.of(context).viewInsets.top,
          padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
          child: Row(
            children: [
              Navigator.of(context).canPop()? BackButton():Container(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}