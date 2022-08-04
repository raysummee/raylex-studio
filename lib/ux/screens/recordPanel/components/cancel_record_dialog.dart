import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/context/app_context.dart';

class CancelRecordDialog extends StatefulWidget {
  const CancelRecordDialog({Key? key, required this.onSave}) : super(key: key);

  static GlobalKey<State>? _keyLoader;
  final VoidCallback onSave;
  static void hide() {
    if (_keyLoader != null &&
        _keyLoader!.currentContext != null &&
        Navigator.of(_keyLoader!.currentContext!, rootNavigator: true)
            .canPop()) {
      Navigator.of(_keyLoader!.currentContext!, rootNavigator: true).pop();
    }
    _keyLoader = null;
  }

  static Future<bool> show({required VoidCallback onSave}) async {
    hide();
    _keyLoader = GlobalKey<State>();
    final bool? r = await showDialog(
        context: navigatorState.currentContext!,
        builder: (_) => CancelRecordDialog(onSave: onSave));
    return r ?? false;
  }

  @override
  State<CancelRecordDialog> createState() => _CancelRecordDialogState();
}

class _CancelRecordDialogState extends State<CancelRecordDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
        key: CancelRecordDialog._keyLoader,
        color: Colors.transparent,
        child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Save Recording?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Do you want to save the current recording?',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.of(context).pop();
                            widget.onSave();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.of(context).pop(true);
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
