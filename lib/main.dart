import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/context/appContext.dart';
import 'package:raylex_studio/routes/routeGenerator.dart';
import 'package:raylex_studio/screens/addedSongs/addedSongs.dart';
import 'package:raylex_studio/screens/home/home.dart';

void main() {
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