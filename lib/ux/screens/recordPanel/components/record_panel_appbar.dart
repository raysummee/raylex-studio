import 'package:flutter/material.dart';

class RecordPanelAppbar extends StatelessWidget {
  const RecordPanelAppbar({Key? key, required this.title, required this.onEnd})
      : super(key: key);
  final String title;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: UnconstrainedBox(
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.02))
          ]),
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: 60 + MediaQuery.of(context).viewPadding.top,
          padding: EdgeInsets.fromLTRB(
              28, MediaQuery.of(context).viewPadding.top, 28, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(78, 41),
                    primary: const Color.fromARGB(255, 255, 80, 80),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    onEnd();
                  },
                  child: const Text(
                    'End',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
