import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raylex_studio/logic/enums/file_type.dart';
import 'package:raylex_studio/logic/enums/record_tile_type.dart';
import 'package:raylex_studio/logic/models/model_track.dart';

class RecordTrackTile extends StatefulWidget {
  const RecordTrackTile(
      {Key? key,
      required this.track,
      required this.index,
      required this.onDelete})
      : super(key: key);
  final ModelTrack track;
  final int index;
  final VoidCallback onDelete;

  @override
  State<RecordTrackTile> createState() => _RecordTrackTileState();
}

class _RecordTrackTileState extends State<RecordTrackTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: widget.onDelete,
      onTap: () {
        if (widget.track.fileType == FileType.audio) {
          setState(() {
            widget.track.recordType =
                widget.track.recordType == RecordTileType.record
                    ? RecordTileType.none
                    : RecordTileType.record;
          });
        } else if (widget.track.fileType == FileType.video) {
          setState(() {
            widget.track.recordType =
                widget.track.recordType == RecordTileType.display
                    ? RecordTileType.none
                    : RecordTileType.display;
          });
        } else {
          debugPrint('Not recordable audio');
          Fluttertoast.showToast(msg: 'The track is not recordable');
        }
      },
      contentPadding: const EdgeInsets.fromLTRB(28, 16, 28, 16),
      title: Text(
        widget.track.name,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      tileColor: Colors.white,
      trailing: () {
        switch (widget.track.recordType) {
          case RecordTileType.none:
            return null;
          case RecordTileType.display:
            return Image.asset(
              'assets/icon/being display.png',
              height: 20,
            );
          case RecordTileType.record:
            return Image.asset(
              'assets/icon/being record.png',
              height: 20,
            );
        }
      }(),
    );
  }
}
