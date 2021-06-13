import 'package:flutter/material.dart';
import 'package:raylex_studio/screens/home/components/recordTile.dart';
import 'package:raylex_studio/screens/home/components/recordTileExpanded.dart';

class ListRecordTile extends StatelessWidget {
  const ListRecordTile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 2),
      itemBuilder: (context, index) => index==0?
        RecordTileExpanded(
          recordLabel: "New Record ${index+1}",
          dateTime: DateTime.now(),
        ):
        RecordTile(
          recordLabel: 'New Record ${index+1}',
          dateTime: DateTime.now(),
        ),
      itemCount: 10,
    );
  }
}