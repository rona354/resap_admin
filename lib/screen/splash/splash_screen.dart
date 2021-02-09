import 'package:flutter/material.dart';
import 'package:resap_admin/screen/splash/components/body.dart';
import 'package:resap_admin/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splashscreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
