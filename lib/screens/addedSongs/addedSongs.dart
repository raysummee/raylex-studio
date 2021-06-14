import 'package:flutter/material.dart';
import 'package:raylex_studio/components/appbar/genericAppbar.dart';
import 'package:raylex_studio/components/tile/songTile.dart';

class AddedSongs extends StatelessWidget {
  const AddedSongs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GenericAppbar(title: "Added Karoke"),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 2),
              itemBuilder: (context, index) => SongTile(
                recordLabel: "Song ${index+1}", 
                dateTime: DateTime.now()
              )
            )
          )
        ],
      ),
    );
  }
}