
import 'package:flutter/material.dart';

class TopLevelNavigatorWrapper extends StatefulWidget {
  TopLevelNavigatorWrapper({this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState()  => _TopLevelNavigatorWrapperState();

}

class _TopLevelNavigatorWrapperState extends State<TopLevelNavigatorWrapper> {

  @override
  Widget build(BuildContext context) {

    return Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                return widget.child;
              });
        });
  }
}