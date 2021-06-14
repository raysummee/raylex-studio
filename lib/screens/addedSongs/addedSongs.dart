import 'package:flutter/material.dart';
import 'package:raylex_studio/components/appbar/genericAppbar.dart';

class AddedSongs extends StatelessWidget {
  const AddedSongs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GenericAppbar(title: "Added Karoke")
        ],
      ),
    );
  }
}