import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';
import 'package:raylex_studio/ux/screens/addedSongs/addedSongs.dart';
import 'package:raylex_studio/ux/screens/home/home.dart';
import 'package:raylex_studio/ux/screens/recordPanel/recordPanel.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/added':
        return MaterialPageRoute(builder: (_) => AddedSongs());
      case '/recordPanel':
        if(settings.arguments.runtimeType==ModelRecord){
          final args = settings.arguments as ModelRecord;
          return MaterialPageRoute(builder: (_) => RecordPanel(record: args,));
        }
        return MaterialPageRoute(builder: (_) => RecordPanel());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}