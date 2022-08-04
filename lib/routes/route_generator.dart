import 'package:flutter/material.dart';
import 'package:raylex_studio/logic/models/model_record.dart';
import 'package:raylex_studio/ux/screens/addedSongs/added_songs.dart';
import 'package:raylex_studio/ux/screens/home/home.dart';
import 'package:raylex_studio/ux/screens/recordPanel/record_panel.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Getting arguments passed in while calling Navigator.pushNamed

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const Home());
    case '/added':
      return MaterialPageRoute(builder: (_) => const AddedSongs());
    case '/recordPanel':
      if (settings.arguments.runtimeType == ModelRecord) {
        final args = settings.arguments as ModelRecord?;
        return MaterialPageRoute(
            builder: (_) => RecordPanel(
                  record: args,
                ));
      }
      return MaterialPageRoute(builder: (_) => const RecordPanel());
    default:
      return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}
