import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:raylex_studio/logic/context/app_context.dart';

class SavingDialog extends StatefulWidget {
  const SavingDialog({Key? key, this.onShowFunc}) : super(key: key);
  static GlobalKey<State>? _keyLoader;
  final Future<bool>? onShowFunc;

  static void hide() {
    if (_keyLoader != null &&
        _keyLoader!.currentContext != null &&
        Navigator.of(_keyLoader!.currentContext!, rootNavigator: true)
            .canPop()) {
      Navigator.of(_keyLoader!.currentContext!, rootNavigator: true).pop();
    }
    _keyLoader = null;
  }

  static Future<void> show(Future<bool> onShowFunc) async {
    hide();
    _keyLoader = GlobalKey<State>();
    await showDialog(
        context: navigatorState.currentContext!,
        barrierDismissible: false,
        builder: (context) => SavingDialog(
              onShowFunc: onShowFunc,
            ));
  }

  @override
  State<SavingDialog> createState() => _SavingDialogState();
}

class _SavingDialogState extends State<SavingDialog> {
  bool saved = false;
  @override
  void initState() {
    if (widget.onShowFunc != null) {
      try {
        widget.onShowFunc!.then((status) {
          if (status) {
            if (mounted) {
              setState(() {
                saved = true;
              });
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            }
          } else {
            Navigator.of(context).pop();
            Fluttertoast.showToast(msg: 'Could not able to save');
          }
        });
      } catch (e) {
        debugPrint(e.toString());
        Navigator.of(context).pop(false);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      key: SavingDialog._keyLoader,
      color: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: saved
                      ? SizedBox(
                          key: GlobalKey(),
                          height: 50,
                          width: 50,
                          child: Lottie.asset('assets/lottie/succeed.json',
                              fit: BoxFit.cover),
                        )
                      : SizedBox(
                          key: GlobalKey(),
                          height: 30,
                          width: 30,
                          child: const CircularProgressIndicator(
                            color: Colors.red,
                          )),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  saved ? 'Saved!!' : 'Saving',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(112, 112, 112, 1)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
