import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/controller/playerController.dart';
import 'package:raylex_studio/logic/controller/recordController.dart';
import 'package:raylex_studio/logic/helpers/modelRecordHelper.dart';
import 'package:raylex_studio/ux/components/tile/songTile.dart';
import 'package:raylex_studio/ux/components/tile/songTileExpanded.dart';

class ListRecordTile extends StatefulWidget {
  const ListRecordTile({ Key? key }) : super(key: key);

  @override
  _ListRecordTileState createState() => _ListRecordTileState();
}

class _ListRecordTileState extends State<ListRecordTile> {
  PlayerController controller = PlayerController();
  int expandedRecording = -1;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ModelRecordHelper().listen(),
      builder: (context, box, child) {
        return ModelRecordHelper().isEmpty()? Container(
          alignment: Alignment.center,
          child: Text(
            "No recording found",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 112, 112, 112)
            ),
          ),
        ):ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 2),
          itemBuilder: (context, index) => AnimatedCrossFade(
            crossFadeState: index==expandedRecording?
              CrossFadeState.showFirst:
              CrossFadeState.showSecond,
            duration: Duration(milliseconds: 300),
            firstChild: SongTileExpanded(
              playerController: controller,
              onDelete: (){
                setState(() {
                  expandedRecording = -1;
                });
                controller.dispose();
                var record = ModelRecordHelper().getAt(index);
                ModelRecordHelper().deleteAt(index);
                RecordController().deleteRecordMedia(record);
              },
              recordLabel: ModelRecordHelper().getAt(index)!.name,
              dateTime: ModelRecordHelper().getAt(index)!.onUpdated,
              track: ModelRecordHelper().getAt(index)!.previewTrack!,
            ),
            secondChild:  SongTile(
              recordLabel: ModelRecordHelper().getAt(index)!.name,
              dateTime: ModelRecordHelper().getAt(index)!.onUpdated,
              onTap: (){
                 setState(() {
                  expandedRecording = index;
                });
              },
            ),
          ),
          itemCount: ModelRecordHelper().length(),
        );
      }
    );
  }
}