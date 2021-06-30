import 'package:flutter/material.dart';
import 'package:raylex_studio/ux/components/appbar/genericAppbar.dart';
import 'components/listRecordTile.dart';
import 'components/recordBottomsheet.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GenericAppbar(title: "Your Recordings",),
          Expanded(
            child: ListRecordTile()
          ),
          RecordBottomsheet()
        ],
      ),
    );
  }
}