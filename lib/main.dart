import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mindmapping/routes/routes.dart';

void main() {
  var router = Router();
  Routes.init(router);
  runApp(App(router: router,));
}

class App extends StatelessWidget {
  final Router router;

  App({this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: router.generator,
    );
  }
}
