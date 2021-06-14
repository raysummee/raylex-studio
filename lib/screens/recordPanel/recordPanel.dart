import 'package:flutter/material.dart';
import 'package:raylex_studio/screens/recordPanel/components/recordPanelAppbar.dart';

class RecordPanel extends StatelessWidget {
  const RecordPanel({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RecordPanelAppbar(title: "Your Song")
        ],
      ),
    );
  }
}