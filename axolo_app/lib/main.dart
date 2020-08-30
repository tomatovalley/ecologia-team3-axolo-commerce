import 'package:axolo_app/src/pages/adn_page.dart';
import 'package:axolo_app/src/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(AxoloApp());

/*
 * Axolo Commerce
 */
class AxoloApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Axolo Commerce',
      initialRoute: 'menu',
      routes: {
        'menu': (BuildContext ctx) => HomePage(),
        'adn': (BuildContext ctx) => AdnPage()
      },
      theme: ThemeData(primaryColor: Colors.green),
    );
  }
}
