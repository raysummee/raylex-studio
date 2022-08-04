import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/context/app_context.dart';

class TwoOptionButtonDialog extends StatelessWidget {
  const TwoOptionButtonDialog(
      {Key? key,
      required this.topLabel,
      required this.topFunc,
      required this.bottomLabel,
      required this.bottomFunc})
      : super(key: key);
      
  final String topLabel;
  final String bottomLabel;
  final VoidCallback topFunc;
  final VoidCallback bottomFunc;

  static Future<void> show(
      {required String topLabel,
      required String bottomLabel,
      required VoidCallback topFunc,
      required VoidCallback bottomFunc}) async {
    showDialog(
        context: appContext!,
        builder: (
          context,
        ) =>
            TwoOptionButtonDialog(
                topLabel: topLabel,
                topFunc: topFunc,
                bottomLabel: bottomLabel,
                bottomFunc: bottomFunc));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            onPressed: topFunc,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                topLabel,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          CupertinoButton(
            onPressed: bottomFunc,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Text(
                bottomLabel,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
