import 'package:flutter/material.dart';
import 'package:raylex_studio/ux/components/appbar/generic_appbar.dart';
import 'components/list_record_tile.dart';
import 'components/record_bottomsheet.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          GenericAppbar(
            title: 'Your Recordings',
          ),
          Expanded(child: ListRecordTile()),
          RecordBottomsheet()
        ],
      ),
    );
  }
}
