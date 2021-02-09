import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resap_admin/screen/dashboard/dashboard.dart';
import 'package:resap_admin/screen/signin/sign_in_screen.dart';
import 'package:resap_admin/services/ServiceAuthentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../size_config.dart';

class SplashScreenView extends StatefulWidget {
  static String routeName = "/splashviewscreen";
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print("#################### SPLASH NIH");
    // Navigator.pushReplacementNamed(context, '/sign_in'));
    // Timer(Duration(seconds: 3),
    //     () => Navigator.pushReplacementNamed(context, SignInScreen.routeName));
    getPreferences().then(routingToWhere);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        "assets/images/welcome.png",
        width: 200.0,
        height: 200.0,
      )),
    );
  }

  void routingToWhere(String token) {
    // token != null
    //     ? Navigator.pushReplacementNamed(context, DashboardScreen.routeName)
    //     : Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    print("#################### Using Preference ${token}");
    // Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    if (token == null || token == "exp") {
      clearPref().then((value) {
        if (value)
          Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      });
    }

    ServiceAuthentication.authByPreference(token).then((value) {
      String _prference = value;
      // print("Di splash : ${_prference}");
      if ("exp" == _prference) {
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      } else {
        print("### Go To Dashboard and save preverence ");
        if (_prference.startsWith('DioError')) {
          setState(() {});
        } else {
          // print(" value from login preference : ${_prference.toString()}");
          saveCredentialPreference(_prference.toString()).then(
              (bool committed) => Navigator.pushReplacementNamed(
                  context, DashboardScreen.routeName));
        }
        Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      }
      // print(_prference.toString());
    });
  }

  Future<String> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    String token = prefs.getString("token");
    print("Splash get preverence : $token");
    return token;
  }

  Future<bool> saveCredentialPreference(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    return prefs.commit();
  }

  Future<bool> clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
