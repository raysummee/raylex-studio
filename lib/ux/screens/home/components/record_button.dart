import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/context/app_context.dart';
import 'package:raylex_studio/ux/components/dialog/two_option_button_dialog.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: CupertinoButton(
        onPressed: () {
          TwoOptionButtonDialog.show(
            topLabel: 'IMPORT NEW',
            topFunc: () {
              Navigator.of(appContext!).pop();
              Navigator.of(context).pushNamed('/recordPanel');
            },
            bottomLabel: 'IMPORT ADDED',
            bottomFunc: () {
              Navigator.of(appContext!).pop();
              Navigator.of(context).pushNamed('/added');
            },
          );
        },
        child: Container(
          height: 69,
          width: 69,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 255, 80, 80),
              boxShadow: [
                BoxShadow(
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.16))
              ]),
        ),
      ),
    );
  }
}
