import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/context/appContext.dart';

class SavingDialog extends StatelessWidget {
  const SavingDialog({ Key? key }) : super(key: key);
  static GlobalKey<State>? _keyLoader;

  static void show(){
    hide();
    _keyLoader = new GlobalKey<State>();
    showDialog(
      context: navigatorState.currentContext!,
      barrierDismissible: false,
      builder: (context) => SavingDialog()
    );
  }
  static void hide(){
    if(_keyLoader!=null
        &&_keyLoader!.currentContext!=null
        &&Navigator.of(_keyLoader!.currentContext!,rootNavigator: true).canPop()
      ){
      Navigator.of(_keyLoader!.currentContext!,rootNavigator: true).pop();
    }
    _keyLoader = null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.red,
              )
            ),
            SizedBox(height: 18,),
            Text(
              "Saving",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(112, 112, 112, 1)
              ),
            )
          ],
        ),
      ),
    );
  }
}