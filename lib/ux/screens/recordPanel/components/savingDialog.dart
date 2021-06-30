import 'package:flutter/material.dart';

class SavingDialog extends StatelessWidget {
  const SavingDialog({ Key? key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          children: [
            CircularProgressIndicator(),
            Text(
              "30%"
            )
          ],
        ),
      ),
    );
  }
}