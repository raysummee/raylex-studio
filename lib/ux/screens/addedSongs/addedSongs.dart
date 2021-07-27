import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/helpers/modelRecordHelper.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';
import 'package:raylex_studio/ux/components/appbar/genericAppbar.dart';
import 'package:raylex_studio/ux/components/tile/songTile.dart';

class AddedSongs extends StatelessWidget {
  const AddedSongs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GenericAppbar(title: "Added Recordings"),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: ModelRecordHelper().listen(),
              builder: (context, Box<ModelRecord> box, child) {
                return ModelRecordHelper().isEmpty()? Container(
                  alignment: Alignment.center,
                  child: Text(
                    "No added recording found",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 112, 112, 112)
                    ),
                  )
                ):
                ListView.builder(
                  padding: EdgeInsets.only(top: 2, bottom: kBottomNavigationBarHeight),
                  itemCount: ModelRecordHelper().length(),
                  itemBuilder: (context, index) => SongTile(
                    onTap: (){
                      Navigator.of(context).pushNamed(
                        "/recordPanel",
                        arguments: ModelRecordHelper().getAt(index)!
                      );
                    },
                    recordLabel: ModelRecordHelper().getAt(index)!.name, 
                    dateTime: ModelRecordHelper().getAt(index)!.onUpdated
                  )
                );
              }
            )
          )
        ],
      ),
    );
  }
}