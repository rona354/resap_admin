import 'package:flutter/material.dart';
import 'package:resap_admin/screen/signin/components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In"),
        backgroundColor: Colors.grey[50],
      ),
      body: Body(),
    );
  }
}
