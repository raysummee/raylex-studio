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
          padding: EdgeInsets.fromLTRB(28, 28, 8, 28),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}