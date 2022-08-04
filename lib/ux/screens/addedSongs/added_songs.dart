import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/helpers/model_record_helper.dart';
import 'package:raylex_studio/logic/models/model_record.dart';
import 'package:raylex_studio/ux/components/appbar/generic_appbar.dart';
import 'package:raylex_studio/ux/components/tile/song_tile.dart';

class AddedSongs extends StatelessWidget {
  const AddedSongs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const GenericAppbar(title: 'Added Recordings'),
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: ModelRecordHelper().listen(),
                  builder: (context, Box<ModelRecord> box, child) {
                    return ModelRecordHelper().isEmpty()
                        ? Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'No added recording found',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 112, 112, 112)),
                            ))
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 2, bottom: kBottomNavigationBarHeight),
                            itemCount: ModelRecordHelper().length(),
                            itemBuilder: (context, index) => SongTile(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/recordPanel',
                                      arguments:
                                          ModelRecordHelper().getAt(index));
                                },
                                recordLabel:
                                    ModelRecordHelper().getAt(index)!.name,
                                dateTime: ModelRecordHelper()
                                    .getAt(index)!
                                    .onUpdated));
                  }))
        ],
      ),
    );
  }
}
