import 'package:flutter/material.dart';

GlobalKey<NavigatorState> _navigatorState = GlobalKey<NavigatorState>();

BuildContext? get appContext => _navigatorState.currentContext;

GlobalKey<NavigatorState> get navigatorState => _navigatorState;