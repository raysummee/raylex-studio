import 'package:flutter/material.dart';
import 'package:raylex_studio/ux/screens/home/components/record_button.dart';

class RecordBottomsheet extends StatelessWidget {
  const RecordBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, -3),
              color: Colors.black.withOpacity(0.02))
        ]),
        height: (MediaQuery.of(context).size.height -
                kToolbarHeight -
                kBottomNavigationBarHeight) *
            0.26,
        width: double.infinity,
        child: const RecordButton());
  }
}
