import 'package:flutter/material.dart';
import 'package:raylex_studio/screens/home/components/recordTile.dart';

class ListRecordTile extends StatelessWidget {
  const ListRecordTile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 2),
      itemBuilder: (context, index) => RecordTile(),
      itemCount: 10,
    );
  }
}