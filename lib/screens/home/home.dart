import 'package:flutter/material.dart';
import 'package:raylex_studio/components/genericAppbar.dart';
import 'package:raylex_studio/screens/home/components/recordBottomsheet.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GenericAppbar(),
          Expanded(child: Container()),
          RecordBottomsheet()
        ],
      ),
    );
  }
}