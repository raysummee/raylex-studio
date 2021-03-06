import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raylex_studio/logic/context/appContext.dart';
import 'package:raylex_studio/logic/db/db.dart';
import 'package:raylex_studio/routes/routeGenerator.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.white, // Color for Android
    statusBarBrightness: Brightness.light //for IOS.
  ));
  await Db().init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raylex Studio',
      navigatorKey: navigatorState,
      theme: ThemeData(
        accentColor: Colors.red,
        primaryColor: Colors.white
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute
    );
  }
}