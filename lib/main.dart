import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resap_admin/routes.dart';
import 'package:resap_admin/screen/splash/splash_screen_view.dart';
import 'package:resap_admin/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RESAPADMIN',
      theme: theme(),
      initialRoute: SplashScreenView.routeName,
      routes: routes,
    );
  }
}
