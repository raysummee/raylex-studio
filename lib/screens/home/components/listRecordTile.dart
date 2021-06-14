import 'package:flutter/material.dart';
import 'package:raylex_studio/components/tile/songTile.dart';
import 'package:raylex_studio/components/tile/songTileExpanded.dart';

class ListRecordTile extends StatefulWidget {
  const ListRecordTile({ Key? key }) : super(key: key);

  @override
  _ListRecordTileState createState() => _ListRecordTileState();
}

class _ListRecordTileState extends State<ListRecordTile> {
  int expandedRecording = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 2),
      itemBuilder: (context, index) => AnimatedCrossFade(
        crossFadeState: index==expandedRecording?
          CrossFadeState.showFirst:
          CrossFadeState.showSecond,
        duration: Duration(milliseconds: 300),
        firstChild: SongTileExpanded(
          recordLabel: "New Record ${index+1}",
          dateTime: DateTime.now(),
        ),
        secondChild:  InkWell(
          onTap: (){
            setState(() {
              expandedRecording = index;
            });
          },
          child: SongTile(
            recordLabel: 'New Record ${index+1}',
            dateTime: DateTime.now(),
          ),
        ),
      ),
      itemCount: 10,
    );
  }
}