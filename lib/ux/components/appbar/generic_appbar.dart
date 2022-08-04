import 'package:flutter/material.dart';

class GenericAppbar extends StatelessWidget {
  const GenericAppbar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.02))
      ]),
      width: double.infinity,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 60 + MediaQuery.of(context).viewInsets.top,
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
          child: Row(
            children: [
              if (Navigator.of(context).canPop())
                const BackButton()
              else
                const SizedBox(),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
