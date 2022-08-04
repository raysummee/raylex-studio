import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raylex_studio/logic/context/app_context.dart';
import 'package:raylex_studio/logic/db/db.dart';
import 'package:raylex_studio/routes/route_generator.dart' as route_generator;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness: Brightness.light //for IOS.
      ));
  await Db().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Raylex Studio',
        navigatorKey: navigatorState,
        theme: ThemeData(primaryColor: Colors.white, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red)),
        initialRoute: '/',
        onGenerateRoute: route_generator.generateRoute);
  }
}
