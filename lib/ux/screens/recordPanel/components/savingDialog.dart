import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/context/appContext.dart';

class SavingDialog extends StatefulWidget {
  const SavingDialog({ Key? key, this.onShowFunc }) : super(key: key);
  static GlobalKey<State>? _keyLoader;
  final Future<void>? onShowFunc; 

  static void hide(){
    if(_keyLoader!=null
        &&_keyLoader!.currentContext!=null
        &&Navigator.of(_keyLoader!.currentContext!,rootNavigator: true).canPop()
      ){
      Navigator.of(_keyLoader!.currentContext!,rootNavigator: true).pop();
    }
    _keyLoader = null;
  }

  static Future<void> show(Future onShowFunc) async{
    hide();
    _keyLoader = new GlobalKey<State>();
    await showDialog(
      context: navigatorState.currentContext!,
      barrierDismissible: false,
      builder: (context) => SavingDialog(onShowFunc: onShowFunc,)
    );
  }

  @override
  _SavingDialogState createState() => _SavingDialogState();
}

class _SavingDialogState extends State<SavingDialog> {
  bool saved=false;
  @override
  void initState() {
    if(widget.onShowFunc!=null){
      widget.onShowFunc!.then((value) {
        if(mounted){
          setState(() {
            saved = true;
          });
          Future.delayed(Duration(milliseconds: 500),(){
            Navigator.of(context).pop();
          });
        }
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      key: SavingDialog._keyLoader,
      color: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async=> false,
        child: Dialog(
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
                  saved?"Saved!!":"Saving",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(112, 112, 112, 1)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}