import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/controller/player_controller.dart';
import 'package:raylex_studio/logic/controller/record_controller.dart';
import 'package:raylex_studio/logic/helpers/model_record_helper.dart';
import 'package:raylex_studio/ux/components/tile/song_tile.dart';
import 'package:raylex_studio/ux/components/tile/song_tile_expanded.dart';

class ListRecordTile extends StatefulWidget {
  const ListRecordTile({Key? key}) : super(key: key);

  @override
  State<ListRecordTile> createState() => _ListRecordTileState();
}

class _ListRecordTileState extends State<ListRecordTile> {
  PlayerController controller = PlayerController();
  int expandedRecording = -1;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ModelRecordHelper().listen(),
        builder: (context, box, child) {
          return ModelRecordHelper().isEmpty()
              ? Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'No recording found',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 112, 112, 112)),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  itemBuilder: (context, index) => AnimatedCrossFade(
                    crossFadeState: index == expandedRecording
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 300),
                    firstChild: SongTileExpanded(
                      active: index == expandedRecording,
                      playerController: controller,
                      onDelete: () {
                        setState(() {
                          expandedRecording = -1;
                        });
                        controller.dispose(soft: true);
                        final record = ModelRecordHelper().getAt(index);
                        ModelRecordHelper().deleteAt(index);
                        RecordController().deleteRecordMedia(record);
                      },
                      recordLabel: ModelRecordHelper().getAt(index)!.name,
                      dateTime: ModelRecordHelper().getAt(index)!.onUpdated,
                      track: ModelRecordHelper().getAt(index)!.previewTrack!,
                    ),
                    secondChild: SongTile(
                      recordLabel: ModelRecordHelper().getAt(index)!.name,
                      dateTime: ModelRecordHelper().getAt(index)!.onUpdated,
                      onTap: () async {
                        if (controller.audioPlayer.isPlaying) {
                          await controller.stop();
                        }
                        setState(() {
                          expandedRecording = index;
                        });
                      },
                    ),
                  ),
                  itemCount: ModelRecordHelper().length(),
                );
        });
  }
}
